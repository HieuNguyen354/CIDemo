//
//  Token.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import Foundation

struct Token: Codable, Equatable {
	let token: String
	let tokenType: String
	
	func getToken() -> String {
		return "\(tokenType) \(token)"
	}
}
