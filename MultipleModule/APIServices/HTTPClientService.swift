//
//  HTTPClientService.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit

protocol HTTPClient {
	func sendRequest<T: Codable, U: Codable>(endpoint: HTTPRequestEndpoint,
											 responseModel: T.Type,
											 internalErrorModel: U.Type,
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
								 responseModel: T.Type,
								 internalErrorModel: U.Type,
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
				if httpURLResponse.statusCode == 403 {
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
	
	
	private func photoDataToFormData(data: Data, boundary: String, fileName: String) -> Data {
		let fullData = NSMutableData()
		
		// 1 - Boundary should start with --
		let lineOne = "--" + boundary + "\r\n"
		if let lineData = lineOne.data(using: .utf8, allowLossyConversion: false) {
			fullData.append(lineData)
		}
		
		// 2
		let lineTwo = "Content-Disposition: form-data; name=\"file\"; filename=\"" + fileName + "\"\r\n"
		if let lineData = lineTwo.data(using: .utf8, allowLossyConversion: false) {
			fullData.append(lineData)
		}
		
		// 3
		let lineThree = "Content-Type: image/jpg\r\n\r\n"
		if let lineData = lineThree.data(using: .utf8, allowLossyConversion: false) {
			fullData.append(lineData)
		}
		
		// 4
		fullData.append(data as Data)
		
		// 5
		let lineFive = "\r\n"
		if let lineData = lineFive.data(using: .utf8, allowLossyConversion: false) {
			fullData.append(lineData)
		}
		
		// 6 - The end. Notice -- at the start and at the end
		let lineSix = "--" + boundary + "--\r\n"
		if let lineData = lineSix.data(using: .utf8, allowLossyConversion: false) {
			fullData.append(lineData)
		}
		
		return Data(referencing: fullData)
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
					let data = photoDataToFormData(data: dataFile,
												   boundary: boundary,
												   fileName: fileName)
					request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
					request.httpBody = data
			}
		}
	}
}

