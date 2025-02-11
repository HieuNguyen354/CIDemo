//
//  UserDefaults.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/1/25.
//

import Foundation

extension UserDefaults {
	subscript<T: RawRepresentable>(key: String) -> T? {
		get {
			if let rawValue = value(forKey: key) as? T.RawValue {
				return T(rawValue: rawValue)
			}
			return nil
		}
		set {
			set(newValue?.rawValue, forKey: key)
		}
	}
	
	subscript<T>(key: String) -> T? {
		get {
			return value(forKey: key) as? T
		}
		set {
			set(newValue, forKey: key)
		}
	}
}
