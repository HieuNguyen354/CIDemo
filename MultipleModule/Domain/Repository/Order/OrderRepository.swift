//
//  OrderRepository.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import RxSwift

protocol OrderRepository {
	func getOrder() -> Single<OrderResponse>
}
