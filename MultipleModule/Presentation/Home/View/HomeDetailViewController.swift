//
//  HomeDetailViewController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit

class HomeDetailViewController: BaseViewController {
	private var heroTitle: String?
	
	private lazy var titleLabel = UILabel()
	var viewModel: HomeDetailViewModel
	
	init(isShowNavigationBar: Bool,
		 viewModel: HomeDetailViewModel,
		 navigationTitle: String) {
		self.viewModel = viewModel
		super.init(isShowNavigationBar: isShowNavigationBar, navigationTitle: navigationTitle)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		titleLabel.applyNormalTitle(textAlignment: .center)
		titleLabel.text = viewModel.heroTitle
	}
	
	override func setupUI() {
		super.setupUI()
		view.addSubview(titleLabel)
	}
	
	override func setupConstraints() {
		super.setupUI()
		titleLabel.snp.makeConstraints {
			$0.edges.equalToSuperview().inset(UIConstraints.halfPadding)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
