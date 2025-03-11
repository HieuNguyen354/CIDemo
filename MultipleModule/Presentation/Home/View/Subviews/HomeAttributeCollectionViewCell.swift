//
//  HomeAttributeCollectionViewCell.swift
//  MultipleModule
//
//  Created by HieuNguyen on 7/3/25.
//

import UIKit

class HomeAttributeCollectionViewCell: BaseCollectionViewCell {
	private lazy var containerView: UIView = {
		let view = UIView()
		view.clipsToBounds = true
		view.roundCorners()
		view.layer.borderColor = AppColors.NeonCarrot.cgColor
		view.layer.borderWidth = 1
		return view
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.regular(size: 16)
		label.textColor = AppColors.TextPrimary
		label.clipsToBounds = true
		label.backgroundColor = AppColors.Clear
		label.textAlignment = .center
		return label
	}()
	
	override func setupUI() {
		super.setupUI()
		contentView.addSubview(containerView)
		containerView.addSubview(titleLabel)
	}
	
	override func setupConstraints() {
		super.setupConstraints()
		containerView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
		
		titleLabel.snp.makeConstraints {
			$0.edges.equalToSuperview().inset(UIConstraints.normalPadding)
		}
	}
	
	func setData(title: String,
				 selectedIndex: PrimaryAttr) {
		titleLabel.text = title
		if title == selectedIndex.rawValue {
			containerView.layer.borderColor = AppColors.Red.cgColor
		} else {
			containerView.layer.borderColor = AppColors.NeonCarrot.cgColor
		}
	}
}
