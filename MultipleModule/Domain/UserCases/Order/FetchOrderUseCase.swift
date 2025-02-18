//
//  FetchOrderUseCase.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import RxSwift

protocol FetchOrderUseCase {
	func execute() -> Single<OrderResponse>
}

class DefaultFetchOrderUseCase: FetchOrderUseCase {
	private let repository: OrderRepository
	
	init(repository: OrderRepository) {
		self.repository = repository
	}
	
	func execute() -> Single<OrderResponse> {
		return repository.getOrder()
	}
}
