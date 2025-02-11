//
//  APIServiceRequest.swift
//  MultipleModule
//
//  Created by HieuNguyen on 21/11/24.
//

import Foundation

protocol APIServiceRequest {
	var method: APIServiceRequestMethod { get }
	var path: String { get }
	var parameters: [String : Any]? { get set }
}
