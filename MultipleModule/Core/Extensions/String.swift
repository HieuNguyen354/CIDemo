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
}
