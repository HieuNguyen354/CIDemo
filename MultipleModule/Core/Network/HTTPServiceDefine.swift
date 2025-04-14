//
//  HTTPServiceDefine.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import Foundation

protocol HTTPRequestEndpoint {
	var host: String { get }
	var scheme: String { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var queryItems: [URLQueryItem]? { get }
	var header: [String: String]? { get }
	var body: [String: Any]? { get }
}

protocol HTTPClientServiceError {
	var statusCode: Int { get set }
	var error: GeneralError? { get set }
}

enum HTTPMethod: String {
	case GET
	case POST
	case PUT
	case DELETE
}

enum GeneralError {
	case decode
	case invalidURL
	case noResponse
	case errorServer
	case undefine(String)
}

struct ErrorServer <T: Codable>: HTTPClientServiceError, Error {
	let internalError: T?
	var statusCode: Int
	var error: GeneralError?
}
