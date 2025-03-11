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
	let responseData = PublishSubject<Void>()
	var currentFilterTitle = [PrimaryAttr]()
	var currentData = HomeDetail()
	var currentFilterData = HomeDetail()

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
			.subscribe { [weak self] _ in
				guard let self else { return }
				reloadTableView()
			}.disposed(by: disposeBag)
		
		primaryAttrSelected
			.subscribe { [weak self] primaryAttr in
				guard let self else { return }
				if primaryAttr == .all {
					currentFilterData = currentData
				} else {
					currentFilterData = currentData.filter { $0.primaryAttr == primaryAttr }
				}
				responseData.onNext(())
			}.disposed(by: disposeBag)
	}
	
	private func reloadTableView() {
		var temp = [Sections]()
		getHeroesSection(&temp)
		sections.accept(temp)
	}
	
	private func getHeroesSection(_ sections: inout [Sections]) {
		var tableViewItem = [SectionModelItem]()
		currentFilterData.forEach { item in
			tableViewItem.append(.listHero(item))
		}
		
		sections.append(Sections(model: .attributes(currentFilterTitle),
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
						currentFilterTitle = Array(Set(model.compactMap { $0.primaryAttr }))
						if let indexOfAllAttr = currentFilterTitle.firstIndex(where: { $0.rawValue == PrimaryAttr.all.rawValue }) {
							currentFilterTitle.remove(at: indexOfAllAttr)
							currentFilterTitle.insert(.all, at: 0)
						}
						currentData = model
						currentFilterData = model
						responseData.onNext(())
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
