//
//  DefaultOrderRepository.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import RxSwift

class DefaultOrderRepository: OrderRepository {
	private let remoteDataSource: OrderRemoteDataSource
	
	init(remoteDataSource: OrderRemoteDataSource) {
		self.remoteDataSource = remoteDataSource
	}
	
	func getOrder() -> Single<OrderResponse> {
		return remoteDataSource.fetchData(apiService: OrderRequest())
			.flatMap { model in
				Single.just(model)
			}
	}
}
