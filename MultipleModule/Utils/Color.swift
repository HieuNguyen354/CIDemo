//
//  Color.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import UIKit

enum AppColors {
	static let primary = UIColor(hex: "#FFA343")
	static let secondary = UIColor(hex: "#c10a26")
	static let background = UIColor(hex: "#1a4c6f")
	static let textPrimary = UIColor(hex: "#FFA343")
	static let textSecondary = UIColor(hex: "#7f8c8d")
	static let red = UIColor.red
	static let white = UIColor.white
}

// UIColor Extension for Hex Support
extension UIColor {
	convenience init(hex: String, alpha: CGFloat = 1.0) {
		var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
		
		var rgb: UInt64 = 0
		Scanner(string: hexSanitized).scanHexInt64(&rgb)
		
		let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
		let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
		let b = CGFloat(rgb & 0x0000FF) / 255.0
		
		self.init(red: r, green: g, blue: b, alpha: alpha)
	}
}
