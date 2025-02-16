//
//  BaseViewModel.swift
//
//
//  Created by HieuNguyen on 12/11/24.
//

import RxSwift

class BaseViewModel: NSObject {
	let disposeBag = DisposeBag()

	override init() {
		super.init()
		setupBindings()
	}

	func setupBindings() { }

}
