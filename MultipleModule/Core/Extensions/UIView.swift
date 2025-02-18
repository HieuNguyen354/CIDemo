//
//  UIView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import UIKit

extension UIView {
	func appDividerLineSetup() {
		backgroundColor = UIColor.lightGray
	}
	
	func addSubViews(_ view: UIView...) {
		view.forEach { self.addSubview($0) }
	}
}
