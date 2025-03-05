//
//  Extension+TimeInterval.swift
//  MultipleModule
//
//  Created by HieuNguyen on 5/3/25.
//

import Foundation

extension TimeInterval {
	func timeString() -> String {
		let hours = Int(self) / 3600
		let minutes = Int(self) % 3600 / 60
		let seconds = Int(self) % 60
		return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
	}
}
