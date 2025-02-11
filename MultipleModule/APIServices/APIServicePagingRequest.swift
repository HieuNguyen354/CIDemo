//
//  APIServicePagingRequest.swift
//  MultipleModule
//
//  Created by HieuNguyen on 21/11/24.
//

protocol APIServicePagingRequest: APIServiceRequest {
	var paging: PagingRequest { get set }
}
