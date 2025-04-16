//
//  HomeManager.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import Foundation
import RxSwift

final class HomeManager {
	var apiService: APIService

	init(apiService: APIService) {
		self.apiService = apiService
	}
	
	func fetchData(apiRequest: APIServiceRequest) -> Single<HomeDetail> {
		return Single<HomeDetail>.create { [weak self] observer in
			guard let self = self else { return Disposables.create() }
			apiService.sendRequest(request: apiRequest,
								   response: HomeDetail.self,
								   error: ErrorResponseModel.self) { response in
				switch response {
					case .success(let model):
						observer(.success(model))
					case .failure(let error):
						observer(.failure(error))
				}
			}
			return Disposables.create()
		}
	}
	
	func fetchHomeDetail(apiRequest: APIServiceRequest) -> Single<HomeDetail> {
		return Single<HomeDetail>.create { [weak self] observer in
			guard let self = self else { return Disposables.create() }
			apiService.sendRequest(request: apiRequest,
								   response: HomeDetail.self,
								   error: ErrorResponseModel.self) { response in
				switch response {
					case .success(let model):
						observer(.success(model))
					case .failure(let error):
						observer(.failure(error))
				}
			}
			return Disposables.create()
		}
	}
	
}
