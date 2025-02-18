//
//  FetchHomeUseCase.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/2/25.
//

import RxSwift

protocol FetchHomeUseCase {
	func execute() -> Single<[HomeModel]>
}

class DefaultFetchHomeUseCase: FetchHomeUseCase {
	private let repository: HomeRepository
	
	init(repository: HomeRepository) {
		self.repository = repository
	}
	
	func execute() -> Single<[HomeModel]> {
		return repository.getHome()
	}
}
