//
//  HomeCell.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit

class HomeCell: BaseTableViewCell {
	
	private lazy var containerView: UIView = {
		let view = UIView()
		view.backgroundColor = AppColors.background
		return view
	}()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.backgroundColor = containerView.backgroundColor
		label.font = AppFonts.bold(size: 18)
		label.textColor = AppColors.primary
		return label
	}()
	
	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.backgroundColor = containerView.backgroundColor
		label.font = AppFonts.italic(size: 16)
		label.textColor = AppColors.secondary
		label.numberOfLines = 0
		return label
	}()
	
	private lazy var dividerLine = UIView()

	override func setupUI() {
		super.setupUI()
		dividerLine.appDividerLineSetup()
		contentView.addSubview(containerView)
		containerView.addSubViews(titleLabel,
								  descriptionLabel,
								  dividerLine)
	}

	override func setupConstraints() {
		super.setupConstraints()
		containerView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}

		titleLabel.snp.makeConstraints {
			$0.top.leading.trailing.equalToSuperview().inset(UIConstraints.normalPadding)
		}

		descriptionLabel.snp.makeConstraints {
			$0.top.equalTo(titleLabel.snp.bottom).offset(UIConstraints.halfPadding)
			$0.leading.trailing.bottom.equalToSuperview().inset(UIConstraints.normalPadding)
		}

		dividerLine.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(UIConstraints.normalPadding)
			$0.bottom.equalToSuperview()
			$0.height.equalTo(0.5)
		}
	}

	func setData(title: String,
				 description: String,
				 isHideDVL: Bool = false) {
		titleLabel.text = title
		descriptionLabel.text = description
		dividerLine.snp.updateConstraints {
			$0.leading.trailing.equalToSuperview().inset(isHideDVL ? .zero : UIConstraints.normalPadding)
		}
	}
}
