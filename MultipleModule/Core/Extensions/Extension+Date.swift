//
//  Extension+Date.swift
//  MultipleModule
//
//  Created by HieuNguyen on 5/3/25.
// ]

import Foundation

extension Date {
	
	static func toDate(from timestamp: Int) -> Date {
		return Date(timeIntervalSince1970: TimeInterval(timestamp))
	}
	
	func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		formatter.locale = Locale(identifier: "vi_VN")
		formatter.timeZone = AppConfigs.currentTimeZone
		return formatter.string(from: self)
	}
}
