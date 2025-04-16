//
//  HomeLocalDataSource.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/2/25.
//

import RxSwift
import RxCocoa

class HomeLocalDataSource {
	private let defaults = UserDefaults.standard
	
	private var data: HomeDetail = [HomeDetailElement]()
	private var cache = GenericCache<HomeDetail>()
	
	func save(_ model: HomeDetail) -> Completable {
		return Completable.create { [weak self] completable in
			guard let self else { return Disposables.create() }
			data = model
			cache.save(value: data, for: "Home")
			completable(.completed)
			return Disposables.create()
		}
	}
	
	func retrieve() -> HomeDetail? {
		guard let savedData = cache.retrieve(for: "Home") else {
			return nil
		}
		return savedData
	}
}
