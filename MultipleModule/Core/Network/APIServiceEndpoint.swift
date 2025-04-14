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
	
	func asURLRequest() -> URLRequest? {
		var components = URLComponents()
		components.scheme = scheme
		components.host = host
		components.path = path
		components.queryItems = queryItems
		
		guard let url = components.url else { return nil }
		
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue
		request.allHTTPHeaderFields = header
		
		if let body = body, !body.isEmpty {
			request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		}
		
		return request
	}
}
