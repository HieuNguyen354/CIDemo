//
//  AppConfigs.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import Foundation

struct AppConfigs {
	static private(set) var currentTimeZone = TimeZone(abbreviation: "GMT+7")

	private(set) static var shared = AppConfigs()

	private(set) var baseUrl: String

	private init() {
		let configs = AppConfigs.getConfigData()
		baseUrl = configs["base_url"] as? String ?? "https://api.opendota.com/"
	}

	static func setup() {
		_ = AppConfigs.shared
	}

	private static func getConfigData() -> [String: AnyObject] {
		var resource = "app_config_release"
		if Environment.isProduction() == false {
			resource = "app_config_debug"
		}
		let path = Bundle.main.path(forResource: resource, ofType: "plist")!
		if let pathNSDictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
			return pathNSDictionary
		}
		return [:]
	}

	// MARK: support for change Environment in The Future
	private mutating func setupConfig(dict: [String: AnyObject]) {
		baseUrl = dict["base_url"] as? String ?? ""
	}
}
