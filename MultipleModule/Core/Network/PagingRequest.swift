//
//  PagingRequest.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import Foundation

struct PagingRequestConfig {
	static let defaultFirstPage = 1
}

struct PagingRequest {
	private(set) var page: Int = PagingRequestConfig.defaultFirstPage

	private(set) var isLastPage: Bool = false

	mutating func increasePage() {
		if isLastPage == false {
			page += 1
		}
	}

	mutating func setLastPage() {
		isLastPage = true
	}

	mutating func setLastPage(by value: Bool) {
		isLastPage = value
	}

	mutating func resetPage() {
		isLastPage = false
		page = PagingRequestConfig.defaultFirstPage
	}

	mutating func setMinPageByZero() {
		page = 0
	}
}
