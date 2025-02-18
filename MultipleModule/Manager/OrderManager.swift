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
	
	func fetchData(apiRequest: APIServiceRequest) -> Single<OrderResponse> {
		return Single<OrderResponse>.create { [weak self] observer in
			guard let self
			else {
				return Disposables.create()
			}
			
			apiService.sendRequest(apiRequest: apiRequest,
								   responseModel: OrderResponse.self,
								   errorModel: ErrorResponseModel.self) { response in
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
