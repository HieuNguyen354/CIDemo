//
//  APIErrorDefine.swift
//  MultipleModule
//
//  Created by HieuNguyen on 15/4/25.
//

enum APIErrorCode: Int {
	case parse = 1000
	case unknown = 2000
	case refreshToken = 401
	case tokenInvalid = 403
	case limitRequest = 429
	
	struct OrderError {
		static let orderProblems = 3000
		static let orderHaveNoItem = 3001
	}
}

enum ApiErrorMessage: String {
	case parse = "ParseError"
	case network = "NetworkError"
	case tokenInvalid = "TokenInvalid"
	case orderProblems = "OrderProblems"
	case limitRequest = "LimitRequest"
	
}
