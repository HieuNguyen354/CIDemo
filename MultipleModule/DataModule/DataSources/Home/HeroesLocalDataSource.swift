//
//  HeroesLocalDataSource.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/2/25.
//

import RxSwift
import RxCocoa

class HeroesLocalDataSource {
	private var data: [HeroesModel] = []
	
	func saveLocal(_ model: [HeroesModel]) -> Completable {
		return Completable.create { [weak self] completable in
			guard let self else { return Disposables.create() }
			data = model
			completable(.completed)
			return Disposables.create()
		}
	}
	
	func getData() -> Single<[HeroesModel]> {
		return Single.just(data)
	}
}
