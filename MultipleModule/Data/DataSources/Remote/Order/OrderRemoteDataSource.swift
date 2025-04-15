//
//  OrderRemoteDataSource.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import RxSwift

class OrderRemoteDataSource {
	func fetchData(apiService: APIServiceRequest) -> Single<OrderResponse> {
		return ClientManager.shared.orderManager.fetchData(apiRequest: apiService)
	}
}
