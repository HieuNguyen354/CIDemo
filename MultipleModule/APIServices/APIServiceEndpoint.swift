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
	var method: HTTPClientServiceRequestMethod
	var queryItems: [URLQueryItem]?
	var header: [String : String]?
	var body: [String : Any]?
	
	init(scheme: String = "https" ,
		 host: String,
		 path: String,
		 method: HTTPClientServiceRequestMethod? = HTTPClientServiceRequestMethod.GET,
		 queryItems: [URLQueryItem]? = nil,
		 header: [String : String]? = nil,
		 body: [String : String]? = nil) {
		self.scheme = scheme
		self.host = host
		self.path = path
		self.method = method ?? .GET
		self.queryItems = queryItems
		self.header = header
		self.body = body
	}
}
