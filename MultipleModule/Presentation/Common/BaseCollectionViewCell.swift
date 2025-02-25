//
//  BaseCollectionViewCell.swift
//  MultipleModule
//
//  Created by HieuNguyen on 25/2/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		setupConstraints()
	}
	
	func setupUI() { }
	func setupConstraints() { }
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
