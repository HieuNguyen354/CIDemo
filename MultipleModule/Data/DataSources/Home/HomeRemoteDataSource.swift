//
//  HomeRemoteDataSource.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/2/25.
//

import Foundation
import RxSwift

class HomeRemoteDataSource {
	func fetchData(apiService: APIServiceRequest) -> Single<HomeDetail> {
		return ClientManager.shared.homeManager.fetchData(apiRequest: apiService)
	}
}
