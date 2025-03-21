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
		self.httpClientService = HTTPClientService(urlSession, encodedType: .json)
		self.httpSerivceQueue = backgroundQueue
	}

	func sendRequest<T: Codable,
					 U: Codable>(apiRequest: APIServiceRequest,
								 responseModel: T.Type,
								 errorModel: U.Type,
								 completion: @escaping Completion<T, U>) {
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
											  completion: @escaping Completion<T, U>) {
		httpSerivceQueue.async { [weak self] in
			guard let self else { return }
			var apiRequest = apiRequest
			var endPoint = APIServiceEndpoint(host: baseURL,
											  path: apiRequest.path,
											  method: HTTPClientServiceRequestMethod(rawValue: apiRequest.method.rawValue),
											  header: getHeader())

			getParameters(apiRequest: &apiRequest)
			getEndPoint(apiRequest: apiRequest,
						parameters: apiRequest.parameters,
						endPoint: &endPoint)

			httpClientService.sendRequest(endpoint: endPoint,
										  responseModel: responseModel,
										  internalErrorModel: internalErrorModel) { httpServiceCompletion in
				DispatchQueue.main.async {
					completion(httpServiceCompletion)
				}
			}
		}
	}
	
	func getParameters(apiRequest: inout APIServiceRequest) {
		if let apiServicePagingRequest = apiRequest as? APIServicePagingRequest {
			apiRequest.parameters?[RequestKey.Paging.page] = apiServicePagingRequest.paging.page
		}
	}
	
	func getEndPoint(apiRequest: APIServiceRequest,
					 parameters: [String: Any]?,
					 endPoint: inout APIServiceEndpoint) {
		guard let parameters else { return }
		switch apiRequest.method {
			case .GET:
				endPoint.queryItems = parameters.map {
					URLQueryItem(name: String($0),
								 value: String(describing: $1))
				}
			case .DELETE:
				endPoint.body = parameters
			case .POST:
				endPoint.body = parameters
			case .PUT:
				endPoint.body = parameters
		}
	}

	func getHeader() -> [String: String] {
		var header = [String: String]()
		header[RequestKey.contentType] = RequestKey.Encoded.normalEncoded
		var userAgent = "\(AppManager.shared.deviceModelName); \(AppManager.shared.deviceOS)"
		if Environment.isProduction() == false {
			userAgent += "; \(String(describing: Environment.status))"
		}
		header[RequestKey.Header.userAgent] = userAgent
		return header
	}

}
