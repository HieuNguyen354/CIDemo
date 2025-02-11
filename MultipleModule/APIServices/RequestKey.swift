//
//  RequestKey.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import Foundation

struct RequestKey {
	static let contentType = "Content-Type"
	
	struct Header {
		static let authorization = "Authorization"
		static let userAgent = "User-Agent"
	}
	
	struct Encoded {
		static let normalEncoded = "application/json; charset=utf-8"
		static let formEncoded = "application/x-www-form-urlencoded"
	}
	
	struct Paging {
		static let page = "page"
	}
	
}
