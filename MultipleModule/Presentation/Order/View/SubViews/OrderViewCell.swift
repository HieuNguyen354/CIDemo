//
//  OrderViewCell.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import UIKit

class OrderViewCell: BaseTableViewCell {
	var profileURLLinkTapped: ((String) -> Void)?
	private var profileURLString: String?
	
	private lazy var containerView: UIView = {
		let view = UIView()
		view.backgroundColor = AppColors.clear
		view.clipsToBounds = true
		return view
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColors.white
		label.font = AppFonts.bold(size: 18)
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
	
	private lazy var lastMatchTimeLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColors.white
		label.font = AppFonts.regular(size: 16)
		label.backgroundColor = containerView.backgroundColor
		label.numberOfLines = 0
		return label
	}()
	
	private lazy var profileURL: UILabel = {
		let label = UILabel()
		label.textColor = AppColors.white
		label.font = AppFonts.regular(size: 16)
		label.backgroundColor = containerView.backgroundColor
		label.numberOfLines = 0
		label.isUserInteractionEnabled = true
		return label
	}()
	
	private lazy var avatar: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 60
		imageView.layer.masksToBounds = false
		imageView.clipsToBounds = true
		imageView.backgroundColor = containerView.backgroundColor
		return imageView
	}()
	
	private lazy var dividerLine = UIView()
	
	override func setupUI() {
		super.setupUI()
		dividerLine.appDividerLineSetup()
		contentView.backgroundColor = AppColors.clear
		contentView.addSubview(containerView)
		containerView.addSubviews(titleLabel,
								  descriptionLabel,
								  lastMatchTimeLabel,
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
		
		lastMatchTimeLabel.snp.makeConstraints {
			$0.top.equalTo(descriptionLabel.snp.bottom).offset(UIConstraints.halfPadding)
			$0.trailing.equalToSuperview().inset(UIConstraints.normalPadding)
			$0.leading.equalTo(avatar.snp.trailing).offset(UIConstraints.normalPadding)
		}
		
		profileURL.snp.makeConstraints {
			$0.top.equalTo(lastMatchTimeLabel.snp.bottom).offset(UIConstraints.halfPadding)
			$0.trailing.equalToSuperview().inset(UIConstraints.normalPadding)
			$0.leading.equalTo(avatar.snp.trailing).offset(UIConstraints.normalPadding)
		}
		
		avatar.snp.makeConstraints {
			$0.leading.top.equalToSuperview().offset(UIConstraints.normalPadding)
			$0.size.equalTo(120)
		}
		
		dividerLine.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(UIConstraints.normalPadding)
			$0.bottom.equalToSuperview()
			$0.height.equalTo(0.5)
			$0.top.greaterThanOrEqualTo(avatar.snp.bottom).offset(UIConstraints.normalPadding)
			$0.top.greaterThanOrEqualTo(profileURL.snp.bottom).offset(UIConstraints.normalPadding)
		}
		
	}
	
	func setData(title: String,
				 description: String,
				 profileURL: String,
				 avatarURL: String,
				 lastMatchTime: String,
				 isHideDVL: Bool = false) {
		titleLabel.text = "Name: \(title)"
		descriptionLabel.text = "TeamName: \(description)"
		if let date = lastMatchTime.toDate(with: "yyyy-MM-dd'T'HH:mm:ss.SSSZ") {
			lastMatchTimeLabel.text = "LastMatchTime: \n\(date.toString(format: "dd-MM-yyyy HH:mm"))"
		} else {
			lastMatchTimeLabel.text = ""
		}
		dividerLine.snp.updateConstraints {
			$0.leading.trailing.equalToSuperview().inset(isHideDVL ? .zero : UIConstraints.normalPadding)
		}
		avatar.setImageURLString(avatarURL)
		setHyperlinkProfileURL(profileURL)
	}
	
	func setHyperlinkProfileURL(_ url: String) {
		profileURLString = url
		let fullText = "ProfileUrl: \(url)"
		let attributedString = NSMutableAttributedString(string: fullText)
		
		// Define range for clickable text
		let linkRange = (fullText as NSString).range(of: url)
		
		// Set attributes
		attributedString.addAttribute(.foregroundColor, value: AppColors.red, range: linkRange)
		attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: linkRange)
		attributedString.addAttribute(.font, value: AppFonts.italic(size: 16), range: linkRange)
		profileURL.attributedText = attributedString
		
		// Add tap gesture
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkTapped))
		profileURL.addGestureRecognizer(tapGesture)
	}
	
	@objc private func linkTapped(gesture: UITapGestureRecognizer) {
		guard let profileURLString,
			  let profileURLLinkTapped,
			  let label = gesture.view as? UILabel else { return }
		let text = label.text ?? ""
		let linkRange = (text as NSString).range(of: profileURLString)
		
		if gesture.didTapAttributedText(in: label, inRange: linkRange) {
			profileURLLinkTapped(profileURLString)
		}
	}
}
