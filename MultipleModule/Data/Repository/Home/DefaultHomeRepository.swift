//
//  DefaultHomeRepository.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/2/25.
//

import RxSwift

class DefaultHomeRepository: HomeRepository {
	private let remoteDataSource: HomeRemoteDataSource
	private let localDataSource: HomeLocalDataSource
	
	init(remoteDataSource: HomeRemoteDataSource, localDataSource: HomeLocalDataSource) {
		self.remoteDataSource = remoteDataSource
		self.localDataSource = localDataSource
	}
	
	func getHome() -> Single<[HomeModel]> {
		return remoteDataSource.fetchData(apiService: HomeRequestModel())
			.flatMap { model in
				self.localDataSource
					.saveLocal(model)
					.andThen(Single.just(model))
			}
			.catch { _ in
				self.localDataSource.getData()
			}
	}
}
