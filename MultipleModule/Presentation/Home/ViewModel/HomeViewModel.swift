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
	typealias Sections = SectionModel<String, HomeModel>
	let sections = BehaviorRelay<[Sections]>(value: [])
	let fetchRX = PublishSubject<Void>()
	let responseData = PublishSubject<[HomeModel]>()
	let fetchHeroesUseCase: FetchHomeUseCase
	
	init(fetchHeroesUseCase: FetchHomeUseCase) {
		self.fetchHeroesUseCase = fetchHeroesUseCase
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

	private func reloadTableView(model: [HomeModel]) {
		var temp = [Sections]()
		getHeroesSection(&temp, model: model)
		sections.accept(temp)
	}

	private func getHeroesSection(_ sections: inout [Sections],
								  model: [HomeModel]) {
		var tableViewItem = [HomeModel]()
		model.sorted(by: { $0.localizedName < $1.localizedName }).forEach { item in
			tableViewItem.append(item)
		}
		sections.append(.init(model: "", items: tableViewItem))
	}

	private func requestData() {
		showLoading.accept(true)
		fetchHeroesUseCase
			.execute()
			.subscribe { [weak self] model in
				guard let self else { return }
				showLoading.accept(false)
				responseData.onNext(model)
			} onFailure: { [weak self] error in
				guard let self else { return }
				showLoading.accept(false)
				print(error)
			}.disposed(by: disposeBag)


	}

}
