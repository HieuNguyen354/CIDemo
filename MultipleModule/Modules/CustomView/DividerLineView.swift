//
//  DividerLineView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 19/11/24.
//

import UIKit

class DividerLineView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI() {
		backgroundColor = UIColor.lightGray
	}
}
