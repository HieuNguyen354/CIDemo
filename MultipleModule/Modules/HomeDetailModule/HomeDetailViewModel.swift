//
//  HomeDetailViewModel.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import RxSwift
import RxCocoa
import RxDataSources

class HomeDetailViewModel: BaseViewModel {
	var heroTitle: String
	
	let result = PublishSubject<String>()
	init(text: String) {
		heroTitle = text
	}
}
