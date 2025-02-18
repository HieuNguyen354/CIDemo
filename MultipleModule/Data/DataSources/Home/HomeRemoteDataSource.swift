//
//  HomeRemoteDataSource.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/2/25.
//

import Foundation
import RxSwift

class HomeRemoteDataSource {
	func fetchData(apiService: APIServiceRequest) -> Single<[HomeModel]> {
		return ClientManager.shared.homeManager.fetchData(apiRequest: apiService)
	}
}
