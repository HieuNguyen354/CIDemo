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
	typealias Sections = SectionModel<SectionModelTitle, SectionModelItem>
	let sections = BehaviorRelay<[Sections]>(value: [])
	let primaryAttrSelected = BehaviorRelay<PrimaryAttr>(value: .all)
	let fetchRX = PublishSubject<Void>()
	let responseData = PublishSubject<HomeDetail>()
	var listFilterTitle = [PrimaryAttr]()
	var currentData = BehaviorRelay<(notFilter: HomeDetail, filtered: HomeDetail)>(value: (notFilter: [], filtered: []))

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
		
		currentData
			.subscribe { [weak self] (_, filtered) in
				guard let self else { return }
				reloadTableView(model: filtered)
			}.disposed(by: disposeBag)
		
		primaryAttrSelected
			.subscribe { [weak self] primaryAttr in
				guard let self else { return }
				if primaryAttr == .all {
					currentData.accept((notFilter: currentData.value.notFilter,
										filtered: currentData.value.notFilter))
				} else {
					currentData.accept((notFilter: currentData.value.notFilter,
										filtered: currentData.value.notFilter.filter { $0.primaryAttr == primaryAttr }))
				}
			}.disposed(by: disposeBag)
	}
	
	private func reloadTableView(model: HomeDetail) {
		var temp = [Sections]()
		getHeroesSection(&temp,
						 model: model)
		sections.accept(temp)
	}
	
	private func getHeroesSection(_ sections: inout [Sections],
								  model: HomeDetail) {
		var tableViewItem = [SectionModelItem]()
		model.forEach { item in
			tableViewItem.append(.listHero(item))
		}
		
		sections.append(Sections(model: .attributes(listFilterTitle),
								 items: tableViewItem))
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
						listFilterTitle = Array(Set(model.compactMap { $0.primaryAttr })).sorted(by: { $0.rawValue < $1.rawValue })
						if let index = listFilterTitle.firstIndex(where: { $0 == PrimaryAttr.all }) {
							listFilterTitle.remove(at: index)
							listFilterTitle.insert(.all, at: 0)
						}
						currentData.accept((notFilter: model, filtered: model))
					case .failure(let error):
						guard let error = error as? ErrorServer<ErrorResponseModel> else { return }
						showAlertError.accept(error.internalError?.error)
				}
			}.disposed(by: disposeBag)
	}
	
}

extension HomeViewModel {
	enum SectionModelTitle {
		case attributes([PrimaryAttr])
	}
	
	enum SectionModelItem {
		case listHero(HomeDetailElement)
	}
}
