//
//  BaseViewModel.swift
//
//
//  Created by HieuNguyen on 12/11/24.
//

import RxSwift
import RxCocoa

class BaseViewModel: NSObject {
	let disposeBag = DisposeBag()
	let showLoading = BehaviorRelay<Bool>(value: false)
	
	override init() {
		super.init()
		setupBindings()
	}

	func setupBindings() { }

	deinit {
		if Environment.isProduction() == false {
			print("deinit " + self.className)
		}
	}
}
