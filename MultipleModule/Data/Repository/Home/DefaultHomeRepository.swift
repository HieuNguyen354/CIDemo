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
	
	init(remoteDataSource: HomeRemoteDataSource,
		 localDataSource: HomeLocalDataSource) {
		self.remoteDataSource = remoteDataSource
		self.localDataSource = localDataSource
	}
	
	func getHome() -> Single<HomeDetail> {
		guard isOnline() else {
			if let cached = localDataSource.retrieve(), !cached.isEmpty {
				return Single.just(localDataSource.retrieve() ?? [])
			} else {
				return .error(ErrorServer(internalError: ErrorResponseModel(error: "No cache data"), statusCode: 0))
			}
		}
		
		var result = remoteDataSource.fetchData(apiService: HomeRequestModel())
		result = result
			.flatMap { [weak self] model in
				guard let self else { return .just([]) }
				return localDataSource.save(model).andThen(Single.just(model))
			}.catch { error in
				return .error(error)
			}
		return result
	}
	
	func getDetail() -> Single<HomeDetail> {
		return ClientManager.shared.homeManager.fetchHomeDetail(apiRequest: HomeDetailRequestModel())
	}
	
	private func isOnline() -> Bool {
		return ReachabilityHelper.shared.isConnectedToNetwork()
	}
}
