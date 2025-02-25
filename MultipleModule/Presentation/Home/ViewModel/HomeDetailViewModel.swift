//
//  HomeDetailViewModel.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import RxSwift
import RxCocoa
import RxDataSources

class HomeDetailViewModel: BaseViewModel {
	typealias Sections = SectionModel<String, HomeDetailElement>
	let sections = BehaviorRelay<[Sections]>(value: [])
	let currentItem = BehaviorRelay<HomeDetailElement?>(value: nil)
	
	init(model: HomeDetailElement) {
		currentItem.accept(model)
	}
	
	override func setupBindings() {
		super.setupBindings()
		currentItem
			.subscribe { [weak self] model in
				guard let self, let model else { return }
				setupTableView(model: model)
			}.disposed(by: disposeBag)
	}
	
	private func setupTableView(model: HomeDetailElement) {
		var tableViewItem = [HomeDetailElement]()
		tableViewItem.append(model)
		sections.accept([Sections(model: "", items: tableViewItem)])
	}
	
}
