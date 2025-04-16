//
//  APIServiceEndpoint.swift
//  MultipleModule
//
//  Created by HieuNguyen on 21/11/24.
//

import Foundation

struct APIServiceEndpoint: HTTPRequestEndpoint {
	var scheme: String
	var host: String
	var path: String
	var method: HTTPMethod
	var queryItems: [URLQueryItem]?
	var header: [String: String]?
	var body: [String: Any]?

	init(scheme: String = "https",
		 host: String,
		 path: String,
		 method: HTTPMethod? = HTTPMethod.GET,
		 queryItems: [URLQueryItem]? = nil,
		 header: [String: String]? = nil,
		 body: [String: Any]? = nil) {
		self.scheme = scheme
		self.host = host
		self.path = path
		self.method = method ?? .GET
		self.queryItems = queryItems
		self.header = header
		self.body = body
	}
	
	func asURLRequest(encodedType: HTTPClientService.EncodedType = .json) -> URLRequest? {
		var components = URLComponents()
		components.scheme = scheme
		components.host = host
		components.path = path
		
		if let queryItems = queryItems {
			components.queryItems = queryItems
		}
		
		guard let url = components.url else { return nil }
		
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue
		request.allHTTPHeaderFields = header
		
		getBody(request: &request, endpointBody: body, encodedType: encodedType)
		return request
	}
	
	private func getBody(request: inout URLRequest, endpointBody: [String: Any]?, encodedType: HTTPClientService.EncodedType = .json) {
		if let body = endpointBody {
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
					request.httpBody = photoData(data: dataFile, boundary: boundary, fileName: fileName)
			}
		}
	}
	
	private func photoData(data: Data, boundary: String, fileName: String) -> Data {
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
}
