//
//  HomePresentViewController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 25/2/25.
//

import UIKit

class HomePresentViewController: BaseViewController {
	private lazy var containerView: UIView = {
		let view = UIView()
		view.backgroundColor = AppColors.background
		view.clipsToBounds = true
		return view
	}()
	
	override func setupUI() {
		super.setupUI()
		view.addSubview(containerView)
	}
	
	override func setupConstraints() {
		super.setupConstraints()
		containerView.snp.makeConstraints {
			$0.edges.equalTo(view.safeAreaLayoutGuide)
		}
	}
}
