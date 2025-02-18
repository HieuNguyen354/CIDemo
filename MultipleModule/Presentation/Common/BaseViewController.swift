//
//  BaseViewController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit
import SnapKit
import RxSwift
import MBProgressHUD

class BaseViewController: UIViewController {
	private var isShowNavigationBar: Bool
	private var navigationTitle: String
	
	private weak var viewModel: BaseViewModel?
	
	let disposeBag = DisposeBag()

	init(isShowNavigationBar: Bool = true,
		 navigationTitle: String = "") {
		self.isShowNavigationBar = isShowNavigationBar
		self.navigationTitle = navigationTitle
		super.init(nibName: nil, bundle: nil)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(!isShowNavigationBar, animated: animated)
		navigationController?.interactivePopGestureRecognizer?.isEnabled = true
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupConstraints()
		setupBindings()
	}

	func setupUI() {
		view.backgroundColor = UIColor.white
		title = navigationTitle
	}

	func setupConstraints() { }
	func setupBindings() {}
	
	func setupRxGeneral(viewModel: BaseViewModel) {
		self.viewModel = viewModel
		viewModel
			.showLoading
			.asDriver()
			.drive(onNext: { [weak self] isShowLoading in
				guard let self else { return }
				self.showLoading(isShowLoading)
			})
			.disposed(by: disposeBag)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	deinit {
		if Environment.isProduction() == false {
			print("deinit " + self.className)
		}
		NotificationCenter.default.removeObserver(self)
	}

	func showLoading(_ isShow: Bool) {
		if isShow == true {
			let hub: MBProgressHUD = MBProgressHUD.showAdded(to: view, animated: true)
			hub.bezelView.backgroundColor = .clear
		} else {
			MBProgressHUD.hide(for: view, animated: true)
		}
	}
}
