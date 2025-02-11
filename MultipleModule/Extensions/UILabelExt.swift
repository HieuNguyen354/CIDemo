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
		font = UIFont.systemFont(ofSize: 16)
		textColor = color
		clipsToBounds = true
		self.textAlignment = textAlignment
		numberOfLines = isMultipleLine ? 0 : 1
	}
	
	func applyMediumTitle(isMultipleLine: Bool = false,
						  with color: UIColor = .black.withAlphaComponent(0.9),
						  textAlignment: NSTextAlignment = .left) {
		font = UIFont.systemFont(ofSize: 14)
		textColor = color
		clipsToBounds = true
		self.textAlignment = textAlignment
		numberOfLines = isMultipleLine ? 0 : 1
	}
	
	func applySmallTitle(isMultipleLine: Bool = false,
						 with color: UIColor = .black.withAlphaComponent(0.9),
						 textAlignment: NSTextAlignment = .left) {
		font = UIFont.systemFont(ofSize: 12)
		textColor = color
		clipsToBounds = true
		self.textAlignment = textAlignment
		numberOfLines = isMultipleLine ? 0 : 1
	}
}
