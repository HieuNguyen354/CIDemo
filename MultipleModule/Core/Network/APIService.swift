//
//  APIService.swift
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
	
	init(baseUrl: String, urlSession: URLSession = URLSession.shared, backgroundQueue: DispatchQueue = DispatchQueue.global(qos: .background)) {
		self.baseURL = baseUrl
		self.httpClientService = HTTPClientService(urlSession, encodedType: .json)
		self.httpSerivceQueue = backgroundQueue
	}
	
	func sendRequest<T: Codable, U: Codable>(request: APIServiceRequest, response: T.Type, error: U.Type, completion: @escaping Completion<T, U>) {
		sendRequestToHttpService(request: request, response: response, error: error) { httpServiceCompletion in
			completion(httpServiceCompletion)
		}
	}
	
	private func sendRequestToHttpService<T: Codable, U: Codable>(request: APIServiceRequest, response: T.Type, error: U.Type, completion: @escaping Completion<T, U>) {
		httpSerivceQueue.async { [weak self] in
			guard let self else { return }
			var request = request
			var endPoint = APIServiceEndpoint(host: baseURL, path: request.path, method: HTTPMethod(rawValue: request.method.rawValue), header: getHeader())
			getParameters(apiRequest: &request)
			getBody(apiRequest: request, parameters: request.parameters, endPoint: &endPoint)
			httpClientService.sendRequest(endpoint: endPoint, response: response, error: error) { httpServiceCompletion in
				DispatchQueue.main.async {
					completion(httpServiceCompletion)
				}
			}
		}
	}
	
	private func getParameters(apiRequest: inout APIServiceRequest) {
		if let pagingRequest = apiRequest as? APIServicePagingRequest {
			apiRequest.parameters?[RequestKey.Paging.page] = pagingRequest.paging.page
		}
	}
	
	private func getBody(apiRequest: APIServiceRequest, parameters: [String: Any]?, endPoint: inout APIServiceEndpoint) {
		guard let parameters else { return }
		switch apiRequest.method {
			case .GET:
				endPoint.queryItems = parameters.map {
					URLQueryItem(name: String($0),
								 value: String(describing: $1))
				}
			default:
				endPoint.body = parameters
		}
	}
	
	private func getHeader() -> [String: String] {
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
