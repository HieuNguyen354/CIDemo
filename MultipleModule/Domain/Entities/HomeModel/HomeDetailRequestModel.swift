//
//  HomeDetailRequestModel.swift
//  MultipleModule
//
//  Created by HieuNguyen on 24/2/25.
//

import Foundation

struct HomeDetailRequestModel: APIServiceRequest {
	var method: APIServiceRequestMethod
	
	var path: String
	
	var parameters: [String: Any]?
	
	init(parameters: [String: Any]? = nil) {
		self.method = .GET
		self.path = "/api/heroStats"
		self.parameters = parameters
	}
}
