//
//  HomeDetailCell.swift
//  MultipleModule
//
//  Created by HieuNguyen on 24/2/25.
//

import UIKit

class HomeDetailCell: BaseTableViewCell {
	private lazy var containerView: UIView = {
		let view = UIView()
		view.backgroundColor = contentView.backgroundColor
		view.clipsToBounds = true
		return view
	}()
	
	override func setupUI() {
		super.setupUI()
		contentView.backgroundColor = AppColors.clear
		contentView.addSubview(containerView)
	}
}
