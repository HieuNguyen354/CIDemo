//
//  String.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit
import CommonCrypto

extension String {
	var txt: String {
		guard let path = Bundle.main.path(forResource: "vi", ofType: "lproj"),
			  let bundle = Bundle(path: path) else {
			return NSLocalizedString(self, comment: "")
		}
		return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
	}
	
	func toDate(with format: String = "HH:mm:ss") -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		dateFormatter.locale = Locale(identifier: "vi_VN") // Ensures correct parsing
		dateFormatter.timeZone = AppConfigs.currentTimeZone
		guard let date = dateFormatter.date(from: self) else {
			return nil
		}
		return date
	}
}
