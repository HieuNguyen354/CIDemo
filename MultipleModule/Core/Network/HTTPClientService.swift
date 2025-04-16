//
//  HTTPClientService.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit

protocol HTTPClient {
	func sendRequest<T: Codable, U: Codable>(endpoint: HTTPRequestEndpoint,
											 response: T.Type,
											 error: U.Type,
											 completion: @escaping (Result<T, ErrorServer<U>>) -> Void)
}

class HTTPClientService: HTTPClient {

	typealias Completion<T: Codable, U: Codable> = ((Result<T, ErrorServer<U>>) -> Void)

	enum EncodedType {
		case json
		case formEncoded
		case file
	}

	let urlSession: URLSession
	let encodedType: EncodedType

	init(_ urlSession: URLSession = URLSession.shared, encodedType: EncodedType = .json) {
		self.urlSession = urlSession
		self.encodedType = encodedType
	}

	func sendRequest<T: Codable, U: Codable>(endpoint: HTTPRequestEndpoint, response: T.Type, error: U.Type, completion: @escaping Completion<T, U>) {
		guard let endpoint = endpoint as? APIServiceEndpoint, let request = endpoint.asURLRequest() else {
			completion(.failure(.init(internalError: nil, statusCode: 0, error: .invalidURL)))
			return
		}
		getTask(with: request, completion: completion)
	}
	
	private func getTask<T: Codable, U: Codable>(with request: URLRequest, completion: @escaping Completion<T, U>) {
		let task = urlSession.dataTask(with: request) { data, urlResponse, error in
			if let error {
				completion(.failure(.init(internalError: nil, statusCode: 0, error: .undefine(error.localizedDescription))))
			}
			guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
				completion(.failure(.init(internalError: nil, statusCode: 0, error: .errorServer)))
				return
			}
			guard let data else { return }
			guard 200...299 ~= httpURLResponse.statusCode else {
				guard httpURLResponse.statusCode != APIErrorCode.tokenInvalid.rawValue else {
					// MARK: - Reauthorization
					return
				}
				do {
					let decode = try JSONDecoder().decode(U.self, from: data)
					completion(.failure(.init(internalError: decode, statusCode: httpURLResponse.statusCode, error: nil)))
				} catch {
					completion(.failure(.init(internalError: nil, statusCode: httpURLResponse.statusCode, error: nil)))
				}
				return
			}
			do {
				let decode = try JSONDecoder().decode(T.self, from: data)
				completion(.success(decode))
			} catch {
				completion(.failure(.init(internalError: nil, statusCode: httpURLResponse.statusCode, error: .decode)))
			}
		}
		
		task.resume()
	}
	
}
