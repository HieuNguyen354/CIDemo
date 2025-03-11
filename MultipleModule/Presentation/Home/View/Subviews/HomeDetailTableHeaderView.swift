//
//  HomeDetailTableHeaderView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 24/2/25.
//
import UIKit

class HomeDetailTableHeaderView: UIView {
	static let height = UIConstraints.calculateRatioSize(originWidth: 1204,
														 originHeight: 679,
														 ratioWidth: UIConstraints.screenSize.width)
	
	private lazy var containerView: UIView = {
		let view = UIView()
		view.backgroundColor = AppColors.Background
		view.clipsToBounds = true
		return view
	}()
	
	private lazy var heroImage: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = containerView.backgroundColor
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.bold(size: 16)
		label.textColor = AppColors.TextPrimary
		label.clipsToBounds = true
		label.backgroundColor = containerView.backgroundColor
		label.numberOfLines = 0
		return label
	}()
	
	private lazy var roleLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.italic(size: 16)
		label.textColor = AppColors.TextPrimary
		label.clipsToBounds = true
		label.backgroundColor = containerView.backgroundColor
		label.numberOfLines = 0
		return label
	}()
	
	private lazy var typeLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.regular(size: 16)
		label.textColor = AppColors.TextPrimary
		label.clipsToBounds = true
		label.backgroundColor = containerView.backgroundColor
		label.numberOfLines = 0
		return label
	}()
	
	private lazy var verticalDividerLine = UIView()
	
	private lazy var bottomLine = UIView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		setupConstraints()
	}
		
	func setupUI() {
		verticalDividerLine.appDividerLineSetup()
		addSubviews(containerView)
		containerView.addSubviews(heroImage,
								  titleLabel,
								  roleLabel,
								  typeLabel,
								  verticalDividerLine,
								  bottomLine)
	}
	
	func setupConstraints() {
		containerView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
		
		heroImage.snp.makeConstraints {
			$0.size.equalTo(HomeDetailTableHeaderView.height)
			$0.top.leading.trailing.equalToSuperview()
		}
		
		titleLabel.snp.makeConstraints {
			$0.top.equalTo(heroImage.snp.bottom).offset(UIConstraints.normalPadding)
			$0.leading.equalToSuperview().offset(UIConstraints.normalPadding)
//			$0.trailing.equalTo(verticalDividerLine.snp.leading).inset(UIConstraints.normalPadding)
		}
		
		roleLabel.snp.makeConstraints {
			$0.top.equalTo(titleLabel.snp.bottom).offset(UIConstraints.halfPadding)
			$0.leading.equalToSuperview().offset(UIConstraints.normalPadding)
//			$0.trailing.equalTo(verticalDividerLine.snp.leading).inset(UIConstraints.normalPadding)
		}
		
		typeLabel.snp.makeConstraints {
			$0.top.equalTo(roleLabel.snp.bottom).offset(UIConstraints.halfPadding)
			$0.leading.equalToSuperview().offset(UIConstraints.normalPadding)
//			$0.trailing.equalTo(verticalDividerLine.snp.leading).inset(UIConstraints.normalPadding)
			$0.bottom.equalToSuperview().inset(UIConstraints.normalPadding)
		}
		
		bottomLine.snp.makeConstraints {
//			$0.top.equalTo(verticalDividerLine.snp.bottom).offset(UIConstraints.normalPadding)
			$0.leading.trailing.bottom.equalToSuperview()
		}
	}
	
	func setData(model: HomeDetailElement) {
		heroImage.setImageURLString("https://cdn.cloudflare.steamstatic.com\(model.img)")
		titleLabel.text = model.localizedName
		roleLabel.text = model.roles.compactMap { $0 }.joined(separator: ", ")
		typeLabel.text = model.primaryAttr.rawValue
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
