//
//  OrderViewCell.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import UIKit

class OrderViewCell: BaseTableViewCell {
	
	private lazy var containerView: UIView = {
		let view = UIView()
		view.backgroundColor = contentView.backgroundColor
		view.clipsToBounds = true
		return view
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColors.white
		label.font = AppFonts.bold(size: 16)
		label.backgroundColor = containerView.backgroundColor
		return label
	}()
	
	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColors.white
		label.font = AppFonts.regular(size: 16)
		label.backgroundColor = containerView.backgroundColor
		return label
	}()
	
	private lazy var profileURL: UILabel = {
		let label = UILabel()
		label.textColor = AppColors.white
		label.font = AppFonts.italic(size: 16)
		label.backgroundColor = containerView.backgroundColor
		return label
	}()
	
	private lazy var dividerLine = UIView()
	
	private lazy var avatar: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 40
		imageView.layer.masksToBounds = false
		imageView.clipsToBounds = true
		imageView.backgroundColor = containerView.backgroundColor
		return imageView
	}()
	
	override func setupUI() {
		super.setupUI()
		dividerLine.appDividerLineSetup()
		contentView.backgroundColor = AppColors.background
		contentView.addSubview(containerView)
		containerView.addSubViews(titleLabel,
								  descriptionLabel,
								  profileURL,
								  dividerLine,
								  avatar)
	}
	
	override func setupConstraints() {
		super.setupConstraints()
		containerView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
		
		titleLabel.snp.makeConstraints {
			$0.top.trailing.equalToSuperview().inset(UIConstraints.normalPadding)
			$0.leading.equalTo(avatar.snp.trailing).offset(UIConstraints.normalPadding)
		}
		
		descriptionLabel.snp.makeConstraints {
			$0.top.equalTo(titleLabel.snp.bottom).offset(UIConstraints.halfPadding)
			$0.trailing.equalToSuperview().inset(UIConstraints.normalPadding)
			$0.leading.equalTo(avatar.snp.trailing).offset(UIConstraints.normalPadding)
		}
		
		profileURL.snp.makeConstraints {
			$0.top.equalTo(descriptionLabel.snp.bottom).offset(UIConstraints.halfPadding)
			$0.trailing.equalToSuperview().inset(UIConstraints.normalPadding)
			$0.leading.equalTo(avatar.snp.trailing).offset(UIConstraints.normalPadding)
		}
		
		dividerLine.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(UIConstraints.normalPadding)
			$0.bottom.equalToSuperview()
			$0.height.equalTo(0.5)
			$0.top.greaterThanOrEqualTo(avatar.snp.bottom).offset(UIConstraints.normalPadding)
			$0.top.greaterThanOrEqualTo(profileURL.snp.bottom).offset(UIConstraints.normalPadding)
		}
		
		avatar.snp.makeConstraints {
			$0.leading.top.equalToSuperview().offset(UIConstraints.normalPadding)
			$0.size.equalTo(80)
		}
	}
	
	func setData(title: String,
				 description: String,
				 profileURL: String,
				 avatarURL: String,
				 isHideDVL: Bool = false) {
		titleLabel.text = title
		descriptionLabel.text = description
		self.profileURL.text = profileURL
		dividerLine.snp.updateConstraints {
			$0.leading.trailing.equalToSuperview().inset(isHideDVL ? .zero : UIConstraints.normalPadding)
		}
		
		avatar.setImageURLString(avatarURL)

	}
}
