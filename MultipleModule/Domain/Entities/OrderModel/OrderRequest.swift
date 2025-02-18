//
//  OrderRequest.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import Foundation

struct OrderRequest: APIServiceRequest {
	var method: APIServiceRequestMethod
	
	var path: String
	
	var parameters: [String: Any]?
	
	init(parameters: [String: Any]? = nil) {
		self.method = .GET
		self.path = "/api/proPlayers"
		self.parameters = parameters
	}
}
