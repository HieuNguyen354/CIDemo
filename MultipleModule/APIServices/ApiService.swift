//
//  ApiService.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit

class APIService {
	
	typealias Completion<T: Codable, U: Codable> = ((Result<T, ErrorServer<U>>) -> Void)
	
	let baseURL: String
	var httpClientService: HTTPClientService
	let httpSerivceQueue: DispatchQueue
	
	init(baseUrl: String,
		 urlSession: URLSession = URLSession.shared,
		 backgroundQueue: DispatchQueue = DispatchQueue.global(qos: .background)) {
		self.baseURL = baseUrl
		self.httpClientService = HTTPClientService(urlSession,
												   encodedType: .json)
		self.httpSerivceQueue = backgroundQueue
	}
	
	func sendRequest<T: Codable,
					 U: Codable>(apiRequest: APIServiceRequest,
								 responseModel: T.Type,
								 errorModel: U.Type,
								 completion: @escaping Completion<T, U>)  {
		sendRequestToHttpService(apiRequest: apiRequest,
								 responseModel: responseModel,
								 internalErrorModel: errorModel) { httpServiceCompletion in
			completion(httpServiceCompletion)
		}
	}
	
	func sendRequestToHttpService<T: Codable,
								  U: Codable>(apiRequest: APIServiceRequest,
											  responseModel: T.Type,
											  internalErrorModel: U.Type,
											  completion: @escaping Completion<T, U>)  {
		httpSerivceQueue.async { [weak self] in
			guard let self else { return }
			var apiRequest = apiRequest
			var endpoint = APIServiceEndpoint(host: baseURL,
											  path: apiRequest.path,
											  method: HTTPClientServiceRequestMethod(rawValue: apiRequest.method.rawValue),
											  header: getHeader(method: apiRequest.method))
			
			if let apiServicePagingRequest = apiRequest as? APIServicePagingRequest {
				apiRequest.parameters?[RequestKey.Paging.page] = apiServicePagingRequest.paging.page
			}
			
			if let parameters = apiRequest.parameters {
				switch apiRequest.method {
					case .GET:
						endpoint.queryItems = parameters.map {
							URLQueryItem(name: String($0),
										 value: String(describing: $1))
						}
					default:
						endpoint.body = parameters
				}
			}
			
			httpClientService.sendRequest(endpoint: endpoint,
										  responseModel: responseModel,
										  internalErrorModel: internalErrorModel) { httpServiceCompletion in
				DispatchQueue.main.async {
					completion(httpServiceCompletion)
				}
			}
		}
	}
	
	func getHeader(method: APIServiceRequestMethod) -> [String: String] {
		var header = [String: String]()
		header[RequestKey.contentType] = RequestKey.Encoded.normalEncoded
		return header
	}
}
