//
//  BaseTableView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 19/11/24.
//

import UIKit

class BaseTableView: UITableView {
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		setupUI()
		setupRegister()
	}

	func setupUI() {
		let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		tableHeaderView = emptyView
		tableFooterView = emptyView
		separatorStyle = .none
		showsVerticalScrollIndicator = false
	}

	func setupRegister() {
		self.register(UITableViewCell.self)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
