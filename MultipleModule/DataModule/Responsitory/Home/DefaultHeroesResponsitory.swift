//
//  DefaultHeroesResponsitory.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/2/25.
//

import RxSwift

class DefaultHeroesResponsitory: HeroesResponsitory {
	private let remote: HeroesRemoteDataSource
	private let local: HeroesLocalDataSource
	
	init(remote: HeroesRemoteDataSource, local: HeroesLocalDataSource) {
		self.remote = remote
		self.local = local
	}
	
	func getHeroes() -> Single<[HeroesModel]> {
		return remote.fetchData(apiService: HomeRequestModel())
			.flatMap { model in
				self.local.saveLocal(model).andThen(Single.just(model))
			}
			.catch { _ in
				self.local.getData()
			}
	}
}
