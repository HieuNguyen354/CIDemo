//
//  OrderViewModel.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import RxSwift
import RxCocoa
import RxDataSources

final class OrderViewModel: BaseViewModel {
	let fetchOrderUseCase: FetchOrderUseCase
	typealias Sections = SectionModel<SectionModelTitle, OrderResponseElement>
	let sections = BehaviorRelay<[Sections]>(value: [])
	let fetchRX = PublishSubject<Void>()
	let responseData = PublishSubject<OrderResponse>()
	
	init(fetchOrderUseCase: FetchOrderUseCase) {
		self.fetchOrderUseCase = fetchOrderUseCase
	}
	
	override func setupBindings() {
		super.setupBindings()
		fetchRX
			.subscribe { [weak self] _ in
				guard let self else { return }
				requestData()
			}.disposed(by: disposeBag)
		
		responseData
			.subscribe { [weak self] model in
				guard let self else { return }
				reloadTableView(model: model)
			}.disposed(by: disposeBag)
	}
	
	func reloadTableView(model: OrderResponse) {
		var temp = [Sections]()
		getHeroesSection(&temp, model: model)
		sections.accept(temp)
	}
	
	private func getHeroesSection(_ sections: inout [Sections],
								  model: OrderResponse) {
		var tableViewItem = [OrderResponseElement]()
		model.forEach { item in
			tableViewItem.append(item)
		}
				
		sections.append(.init(model: .empty, items: tableViewItem))
	}
	
	private func requestData() {
		showLoading.accept(true)
		fetchOrderUseCase
			.execute()
			.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
			.observe(on: MainScheduler.instance)
			.subscribe { [weak self] result in
				guard let self else { return }
				showLoading.accept(false)
				switch result {
					case .success(let model):
						responseData.onNext(model)
					case .failure(let error):
						guard let error = error as? ErrorServer<ErrorResponseModel> else { return }
						showAlertError.accept(error.internalError?.error)
				}
			}.disposed(by: disposeBag)
	}
	
}

extension OrderViewModel {
	enum SectionModelTitle {
		case empty
		case title(String)
		
		var rawValue: String {
			switch self {
				case .empty:
					return ""
				case .title(let text):
					return text
			}
		}
	}
}
