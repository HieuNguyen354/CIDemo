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
		return view
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.bold(size: 16)
		label.textColor = AppColors.textPrimary
		label.clipsToBounds = true
		label.backgroundColor = containerView.backgroundColor
		return label
	}()
	
	private lazy var roleLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.italic(size: 16)
		label.textColor = AppColors.textPrimary
		label.clipsToBounds = true
		label.backgroundColor = containerView.backgroundColor
		return label
	}()
	
	private lazy var typeLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.regular(size: 16)
		label.textColor = AppColors.textPrimary
		label.clipsToBounds = true
		label.backgroundColor = containerView.backgroundColor
		return label
	}()
	
	override func setupUI() {
		super.setupUI()
		contentView.backgroundColor = AppColors.background
		contentView.addSubview(containerView)
		containerView.addSubViews(titleLabel,
								  roleLabel,
								  typeLabel)
	}
}
