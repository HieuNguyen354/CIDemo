//
//  Extension+UIButton.swift
//  MultipleModule
//
//  Created by HieuNguyen on 11/3/25.
//

import UIKit

extension UIButton {
	func setTitle(title: String?) {
		setTitle(title, for: .normal)
		setTitle(title, for: .highlighted)
	}
}
