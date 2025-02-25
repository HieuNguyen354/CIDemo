//
//  HomeReponsitory.swift
//  MultipleModule
//
//  Created by HieuNguyen on 16/2/25.
//

import Foundation
import RxSwift

protocol HomeRepository {
	func getHome() -> Single<HomeDetail>
	func getDetail() -> Single<HomeDetail>
}
