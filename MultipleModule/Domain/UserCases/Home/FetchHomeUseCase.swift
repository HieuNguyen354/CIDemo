//
//  FetchHomeUseCase.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/2/25.
//

import RxSwift

protocol FetchHomeUseCase {
	func execute() -> Single<HomeDetail>
	func getDetail() -> Single<HomeDetail>
}

class DefaultFetchHomeUseCase: FetchHomeUseCase {
	private let repository: HomeRepository
	
	init(repository: HomeRepository) {
		self.repository = repository
	}
	
	func execute() -> Single<HomeDetail> {
		return repository.getHome()
	}
	
	func getDetail() -> Single<HomeDetail> {
		return repository.getDetail()
	}
}
