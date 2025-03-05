//
//  UIView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import UIKit

extension UIView {
	func appDividerLineSetup() {
		backgroundColor = AppColors.white
	}
	
	func addSubviews(_ view: UIView...) {
		view.forEach { self.addSubview($0) }
	}
}
