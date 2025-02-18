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
		view.backgroundColor = AppColors.white
		return view
	}()
	
	private lazy var titleLabel = UILabel()
	private lazy var descriptionLabel = UILabel()
	private lazy var profileURL = UILabel()
	private lazy var dividerLine = UIView()
	
	private lazy var avatar: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 40
		imageView.layer.masksToBounds = false
		imageView.clipsToBounds = true
		return imageView
	}()
	
	override func setupUI() {
		super.setupUI()
		titleLabel.applyNormalTitle(textAlignment: .left)
		descriptionLabel.applyMediumTitle(textAlignment: .left)
		profileURL.applyMediumTitle(isMultipleLine: true, textAlignment: .left)
		dividerLine.appDividerLineSetup()
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
			$0.top.greaterThanOrEqualTo(avatar.snp.bottom).offset(UIConstraints.halfPadding)
			$0.top.greaterThanOrEqualTo(profileURL.snp.bottom).offset(UIConstraints.halfPadding)
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
		
		avatar.load(url: URL(string: avatarURL))

	}
}
