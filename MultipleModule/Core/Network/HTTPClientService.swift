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

	init(_ urlSession: URLSession = URLSession.shared,
		 encodedType: EncodedType = .json) {
		self.urlSession = urlSession
		self.encodedType = encodedType
	}

	func sendRequest<T: Codable,
					 U: Codable>(endpoint: HTTPRequestEndpoint,
								 response: T.Type,
								 error: U.Type,
								 completion: @escaping Completion<T, U>) {
		var urlComponent = URLComponents()
		urlComponent.scheme = endpoint.scheme
		urlComponent.host = endpoint.host
		urlComponent.path = endpoint.path
		
		if let queryItems = endpoint.queryItems {
			urlComponent.queryItems = queryItems
		}

		guard let url = urlComponent.url else {
			completion(.failure(.init(internalError: nil,
									  statusCode: 0,
									  error: .invalidURL)))
			return
		}

		var request = URLRequest(url: url)
		request.httpMethod = endpoint.method.rawValue
		request.allHTTPHeaderFields = endpoint.header
		getBody(request: &request, endpoint: endpoint)
		getTask(with: request, completion: completion)
	}

	private func getBody(request: inout URLRequest,
						 endpoint: HTTPRequestEndpoint) {
		if let body = endpoint.body {
			switch encodedType {
				case .json:
					request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
				case .formEncoded:
					if let body = body
						.reduce("", { "\($0)\($1.0)=\($1.1)&" })
						.dropLast()
						.data(using: .utf8,
							  allowLossyConversion: false) {
						request.httpBody = body
					}
				case .file:
					guard let dataString = body["file"] as? String else { return }
					let dataFile: Data = Data(base64Encoded: dataString, options: .ignoreUnknownCharacters)!
					let fileName = body["fileName"] as? String ?? ""
					let boundary = UUID().uuidString
					request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
					request.httpBody = Data().photoData(data: dataFile, boundary: boundary, fileName: fileName)
			}
		}
	}
	
	private func getTask<T: Codable,
						 U: Codable>(with request: URLRequest,
									 completion: @escaping Completion<T, U>) {
		let task = urlSession.dataTask(with: request) { data, urlResponse, error in
			if let error {
				completion(.failure(.init(internalError: nil,
										  statusCode: 0,
										  error: .undefine(error.localizedDescription))))
			}
			
			guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
				completion(.failure(.init(internalError: nil,
										  statusCode: 0,
										  error: .errorServer)))
				return
			}
			
			guard 200...299 ~= httpURLResponse.statusCode else {
				guard httpURLResponse.statusCode != ApiErrorCode.tokenInvalid.rawValue else {
					// MARK: - Reauthorization
					return
				}
				
				do {
					guard let data else { return }
					let decode = try JSONDecoder().decode(U.self, from: data)
					completion(.failure(.init(internalError: decode,
											  statusCode: httpURLResponse.statusCode,
											  error: nil)))
				} catch {
					completion(.failure(.init(internalError: nil,
											  statusCode: httpURLResponse.statusCode,
											  error: nil)))
				}
				
				return
			}
			
			do {
				guard let data else { return }
				let decode = try JSONDecoder().decode(T.self, from: data)
				completion(.success(decode))
			} catch {
				completion(.failure(.init(internalError: nil,
										  statusCode: httpURLResponse.statusCode,
										  error: .decode)))
			}
		}
		
		task.resume()
	}
}
