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
		view.backgroundColor = AppColors.white
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
		
		viewModel
			.showAlertError
			.asDriver()
			.drive(onNext: { [weak self] errorMessage in
				guard let self = self,
					  let message = errorMessage else {
					return
				}
				self.endRefresherAndLoadMore()
				viewModel.showLoading.accept(false)
				self.showErrorAlert(message: message)
			})
			.disposed(by: disposeBag)
	}

	func showLoading(_ isShow: Bool) {
		if isShow == true {
			let hub: MBProgressHUD = MBProgressHUD.showAdded(to: view, animated: true)
			hub.bezelView.backgroundColor = .clear
		} else {
			MBProgressHUD.hide(for: view, animated: true)
		}
	}
	
	func scrollToTop(_ animated: Bool = true) {
		for item in view.subviews {
			if let tableView = item as? UITableView {
				tableView.setContentOffset(CGPoint(x: 0,
												   y: -tableView.contentInset.top),
										   animated: animated)
				break
			}
		}
	}
	
	func endRefresherAndLoadMore() {
		for item in view.subviews {
			if let tableView = item as? BaseTableView {
				tableView.tableFooterView = nil
				break
			}
		}
		
		endRefresherIfNeeded()
	}
	
	func endRefresherIfNeeded(_ animated: Bool = false) {
		for item in view.subviews {
			if let tableView = item as? BaseTableView {
				guard tableView.refreshControl != nil else { return }
				if tableView.contentOffset.y < tableView.contentInset.top {
					tableView.refresher.endRefreshing()
					scrollToTop(animated)
				}
				break
			}
		}
	}
	
	func showErrorAlert(_ title: String = "Lỗi",
					   message: String) {
		let alert = BaseAlertBuilder()
		alert
			.buttons(titles: [.init(index: 0,
									title: "Xong".txt)])
			.message(message: message)
			.title(title: title)
			.parentViewController(rootVC: self)
			.showAlert()
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

}
