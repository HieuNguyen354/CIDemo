//
//  FetchHeroesUseCase.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/2/25.
//

import RxSwift

protocol FetchHeroesUseCase {
	func execute() -> Single<[HeroesModel]>
}

class DefaultFetchHeroesUseCase: FetchHeroesUseCase {
	private let resonsitory: HeroesResponsitory
	
	init(resonsitory: HeroesResponsitory) {
		self.resonsitory = resonsitory
	}
	
	func execute() -> Single<[HeroesModel]> {
		return resonsitory.getHeroes()
	}
}
