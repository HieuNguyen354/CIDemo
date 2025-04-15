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
	let filteredData = BehaviorRelay<HomeDetail>(value: [])
	let currentData = BehaviorRelay<HomeDetail>(value: [])
	let error = PublishSubject<ErrorServer<ErrorResponseModel>>()
	
	private var listFilterTitle = [PrimaryAttr]()
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
			.subscribe { [weak self] model in
				guard let self else { return }
				filteredData.accept(model)
			}.disposed(by: disposeBag)
		
		filteredData
			.subscribe { [weak self] _ in
				guard let self else { return }
				reloadTableView()
			}.disposed(by: disposeBag)
		
		error
			.subscribe { [weak self] error in
				guard let self, let interalError = error.internalError else { return }
				showAlertError.accept(interalError.error)
			}.disposed(by: disposeBag)
		
		primaryAttrSelected
			.subscribe { [weak self] primaryAttr in
				guard let self else { return }
				filteredData.accept(primaryAttr == .all ? currentData.value : currentData.value.filter { $0.primaryAttr == primaryAttr })
			}.disposed(by: disposeBag)
	}
	
	private func reloadTableView() {
		var temp = [Sections]()
		getHeroesSection(&temp)
		sections.accept(temp)
	}
	
	private func getHeroesSection(_ sections: inout [Sections]) {
		var tableViewItem = [SectionModelItem]()
		filteredData.value.forEach { item in
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
						currentData.accept(model)
					case .failure(let error):
						guard let error = error as? ErrorServer<ErrorResponseModel> else { return }
						self.error.onNext(error)
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
