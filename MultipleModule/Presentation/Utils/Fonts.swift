//
//  Fonts.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import UIKit

enum AppFonts {
	static func regular(size: CGFloat) -> UIFont {
		return UIFont(name: "HelveticaNeue", size: size) ?? UIFont.systemFont(ofSize: size)
	}
	
	static func bold(size: CGFloat) -> UIFont {
		return UIFont(name: "HelveticaNeue-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
	}
	
	static func italic(size: CGFloat) -> UIFont {
		return UIFont(name: "HelveticaNeue-Italic", size: size) ?? UIFont.italicSystemFont(ofSize: size)
	}
}
