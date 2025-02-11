//
//  BaseViewController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit
import SnapKit
import RxSwift

class BaseViewController: UIViewController {
	let disposeBag = DisposeBag()
	private var isShowNavigationBar: Bool
	private var navigationTitle: String
	
	init(isShowNavigationBar: Bool = true,
		 navigationTitle: String) {
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
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
