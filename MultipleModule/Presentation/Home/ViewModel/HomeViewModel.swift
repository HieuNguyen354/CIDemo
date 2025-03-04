//
//  HomeViewModel.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewModel: BaseViewModel {
	typealias Sections = SectionModel<String, HomeDetailElement>
	let sections = BehaviorRelay<[Sections]>(value: [])
	let fetchRX = PublishSubject<Void>()
	let responseData = PublishSubject<HomeDetail>()
	
	private let fetchHomeUseCase: FetchHomeUseCase
	
	init(fetchHomeUseCase: FetchHomeUseCase) {
		self.fetchHomeUseCase = fetchHomeUseCase
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
	
	private func reloadTableView(model: HomeDetail) {
		var temp = [Sections]()
		getHeroesSection(&temp, model: model)
		sections.accept(temp)
	}
	
	private func getHeroesSection(_ sections: inout [Sections],
								  model: HomeDetail) {
		var tableViewItem = HomeDetail()
		model.forEach { item in
			tableViewItem.append(item)
		}
		sections.append(.init(model: "", items: tableViewItem))
	}
	
	private func requestData() {
		showLoading.accept(true)
		
		fetchHomeUseCase
			.execute()
			.map { $0.sorted(by: { $0.localizedName < $1.localizedName }) }
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
