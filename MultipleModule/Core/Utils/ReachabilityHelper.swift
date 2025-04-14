//
//  ReachabilityHelper.swift
//  MultipleModule
//
//  Created by HieuNguyen on 24/2/25.
//

import Reachability

class ReachabilityHelper {
	static let shared = ReachabilityHelper()
	private let reachability = try? Reachability()
	
	private init() {
		try? reachability?.startNotifier()
	}
	
	func isConnectedToNetwork() -> Bool {
		return reachability?.connection != .unavailable
	}
}
