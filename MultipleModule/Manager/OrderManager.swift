//
//  OrderManager.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import Foundation
import RxSwift

final class OrderManager {
	var apiService: APIService
	
	init(apiService: APIService) {
		self.apiService = apiService
	}
	
	func fetchData<T: Codable>(apiRequest: APIServiceRequest) -> Single<T> {
		return Single<T>.create { [weak self] observer in
			guard let self else { return Disposables.create() }
			apiService.sendRequest(request: apiRequest,
								   response: T.self,
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
