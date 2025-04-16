//
//  Extension+Cacheable.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/4/25.
//

import UIKit

protocol Cacheable {
	associatedtype Key
	associatedtype Value
	
	func retrieve(for key: Key) -> Value?
	func save(value: Value, for key: Key)
}

extension Cacheable where Key == String, Value: Codable {
	func saveToUserDefaults(value: Value, for key: Key) {
		let data = try? JSONEncoder().encode(value)
		UserDefaults.standard.set(data, forKey: key)
	}
	
	func retrieveFromUserDefaults(for key: Key) -> Value? {
		guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
		return try? JSONDecoder().decode(Value.self, from: data)
	}
}

class GenericCache<T: Codable>: Cacheable {
	typealias Key = String
	typealias Value = T
	
	func save(value: T, for key: String) {
		saveToUserDefaults(value: value, for: key)
	}
	
	func retrieve(for key: String) -> T? {
		retrieveFromUserDefaults(for: key)
	}
}
