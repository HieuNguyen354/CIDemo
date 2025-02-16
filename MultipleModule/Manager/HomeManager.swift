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
	
	func fetchData(apiRequest: APIServiceRequest) -> Single<[HeroesModel]> {
		return Single<[HeroesModel]>.create { [weak self] observer in
			guard let self = self else { return Disposables.create() }
			apiService.sendRequest(apiRequest: apiRequest,
								   responseModel: [HeroesModel].self,
								   errorModel: ErrorResponseModel.self) { [weak self] response in
				guard let self else { return }
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
