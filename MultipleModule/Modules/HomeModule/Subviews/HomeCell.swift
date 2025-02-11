//
//  HomeCell.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit

class HomeCell: UITableViewCell {
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		setupConstraints()
	}
	
	private lazy var containerView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.white
		return view
	}()
	
	private lazy var titleLabel = UILabel()
	private lazy var descriptionLabel = UILabel()
	
	private lazy var dividerLine = DividerLineView()
	
	func setupUI() {
		titleLabel.applyNormalTitle(textAlignment: .center)
		descriptionLabel.applyMediumTitle(textAlignment: .center)
		contentView.addSubview(containerView)
		containerView.addSubview(titleLabel)
		containerView.addSubview(descriptionLabel)
		containerView.addSubview(dividerLine)
	}
	
	func setupConstraints() {
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
			$0.leading.trailing.equalToSuperview().inset(16)
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
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
