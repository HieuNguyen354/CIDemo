//
//  HeroesRemoteDataSource.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/2/25.
//

import Foundation
import RxSwift

class HeroesRemoteDataSource {
	func fetchData(apiService: APIServiceRequest) -> Single<[HeroesModel]> {
		return ClientManager.shared.homeManager.fetchData(apiRequest: apiService)
	}
}
