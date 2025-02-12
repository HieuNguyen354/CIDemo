//
//  ClientManager.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit

final class ClientManager {
	static var shared = ClientManager()

	var homeManager = HomeManager(apiService: APIService(baseUrl: AppConfigs.shared.baseUrl))

	private init() {
		AppConfigs.setup()
	}

	class func start() {
		_ = ClientManager.shared
	}

	class func reset() {
		shared = ClientManager()
	}
}
