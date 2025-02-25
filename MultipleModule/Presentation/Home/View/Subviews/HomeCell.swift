//
//  HomeCell.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit

class HomeCell: BaseCollectionViewCell {
	static let totalPadding = padding * (2)
	static let originWidth: CGFloat = UIConstraints.screenSize.width / 3 - HomeCell.totalPadding
	static let originHeight: CGFloat = HomeCell.originWidth
	static let padding = UIConstraints.halfPadding
	static let size = CGSize(width: HomeCell.originWidth, height: HomeCell.originHeight)
	
	private lazy var containerView: UIView = {
		let view = UIView()
		view.backgroundColor = AppColors.background
		view.clipsToBounds = true
		return view
	}()
	
	private lazy var heroImage: UIImageView = {
		let imageView = UIImageView()
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	private lazy var heroTitle: UILabel = {
		let label = UILabel()
		label.textColor = AppColors.white
		label.font = AppFonts.regular(size: 16)
		label.backgroundColor = containerView.backgroundColor
		label.clipsToBounds = true
		label.textAlignment = .center
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.5
		label.numberOfLines = 1
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		setupConstraints()
	}
	
	override func setupUI() {
		super.setupUI()
		contentView.addSubview(containerView)
		containerView.addSubViews(heroImage,
								  heroTitle)
	}

	override func setupConstraints() {
		super.setupConstraints()
		containerView.snp.makeConstraints {
			$0.edges.equalToSuperview()
			$0.size.equalTo(CGSize(width: HomeCell.size.width,
								   height: HomeCell.size.height))
		}

		heroImage.snp.makeConstraints {
			$0.size.equalTo(CGSize(width: HomeCell.size.width,
								   height: HomeCell.size.height * 0.5))
			$0.top.leading.trailing.equalToSuperview()
		}
		
		heroTitle.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview()
			$0.top.equalTo(heroImage.snp.bottom).offset(4)
		}
	}
	
	func setData(title: String,
				 url: String) {
		heroTitle.text = title
		heroImage.setImageURLString("\(AppDefine.ImageLink.url)\(url)")
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
