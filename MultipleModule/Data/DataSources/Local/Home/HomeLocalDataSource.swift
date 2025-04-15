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
	
	func saveLocal(_ model: HomeDetail) -> Completable {
		return Completable.create { [weak self] completable in
			guard let self else { return Disposables.create() }
			data = model
			if let encoded = try? JSONEncoder().encode(model) {
				defaults.set(encoded, forKey: "userProfile")
			}
			completable(.completed)
			return Disposables.create()
		}
	}
	
	func getData() -> HomeDetail? {
		guard let savedData = defaults.data(forKey: "userProfile"),
			  let decoded = try? JSONDecoder().decode(HomeDetail.self, from: savedData) else {
			return nil
		}
		return decoded
	}
}
