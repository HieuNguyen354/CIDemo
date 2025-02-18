//
//  HomeLocalDataSource.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/2/25.
//

import RxSwift
import RxCocoa

class HomeLocalDataSource {
	private var data: [HomeModel] = []
	
	func saveLocal(_ model: [HomeModel]) -> Completable {
		return Completable.create { [weak self] completable in
			guard let self else { return Disposables.create() }
			data = model
			completable(.completed)
			return Disposables.create()
		}
	}
	
	func getData() -> Single<[HomeModel]> {
		return Single.just(data)
	}
}
