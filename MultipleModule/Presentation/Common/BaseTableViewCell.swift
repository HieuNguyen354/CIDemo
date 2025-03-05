//
//  BaseTableViewCell.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		setupUI()
		setupConstraints()
		setupBindings()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI() { }
	func setupConstraints() { }
	func setupBindings() { }
}
