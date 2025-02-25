//
//  UIView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import UIKit

extension UIView {
	func appDividerLineSetup() {
		backgroundColor = AppColors.secondary
	}
	
	func addSubViews(_ view: UIView...) {
		view.forEach { self.addSubview($0) }
	}
}
