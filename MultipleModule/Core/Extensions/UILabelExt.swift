//
//  UILabelExt.swift
//  MultipleModule
//
//  Created by HieuNguyen on 10/2/25.
//

import UIKit

extension UILabel {
	func applyNormalTitle(isMultipleLine: Bool = false,
						  with color: UIColor = .black.withAlphaComponent(0.9),
						  textAlignment: NSTextAlignment = .left) {
		font = AppFonts.regular(size: 16)
		textColor = color
		clipsToBounds = true
		self.textAlignment = textAlignment
		numberOfLines = isMultipleLine ? 0 : 1
	}

	func applyMediumTitle(isMultipleLine: Bool = false,
						  with color: UIColor = .black.withAlphaComponent(0.9),
						  textAlignment: NSTextAlignment = .left) {
		font = AppFonts.regular(size: 14)
		textColor = color
		clipsToBounds = true
		self.textAlignment = textAlignment
		numberOfLines = isMultipleLine ? 0 : 1
	}

	func applySmallTitle(isMultipleLine: Bool = false,
						 with color: UIColor = .black.withAlphaComponent(0.9),
						 textAlignment: NSTextAlignment = .left) {
		font = AppFonts.regular(size: 12)
		textColor = color
		clipsToBounds = true
		self.textAlignment = textAlignment
		numberOfLines = isMultipleLine ? 0 : 1
	}
}
