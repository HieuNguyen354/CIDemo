//
//  HomeRequestModel.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import Foundation

struct HomeRequestModel: APIServiceRequest {
	var method: APIServiceRequestMethod
	
	var path: String
	
	var parameters: [String : Any]?
	
	init(parameters: [String : Any]? = nil) {
		self.method = .GET
		self.path = "/api/heroes"
		self.parameters = parameters
	}
}
