//
//  HomeViewController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit
import RxDataSources
import RxSwift

class HomeViewController: BaseViewController {
	var viewModel: HomeViewModel
	var coordinator: HomeCoordinator?

	private lazy var tableView: BaseTableView = {
		let tableView = BaseTableView(frame: .zero, style: .grouped)
		tableView.register(HomeCell.self)
		tableView.contentInset.bottom = .zero
		return tableView
	}()

	typealias DataSource = RxTableViewSectionedReloadDataSource<HomeViewModel.Sections>
	private lazy var dataSource = DataSource { dataSource, tableView, indexPath, item in
		if let cell = tableView.on_dequeue(HomeCell.self, for: indexPath) {
			cell.setData(title: item.localizedName,
						 description: item.roles.reduce("") { $0.isEmpty ? $1 : $1.isEmpty ? "" : "\($0) - \($1)" },
						 isHideDVL: indexPath.row == dataSource[indexPath.section].items.count - 1)
			return cell
		}

		return tableView.on_dequeueDefaultCell()
	}

	init(isShowNavigationBar: Bool,
		 viewModel: HomeViewModel,
		 navigationTitle: String) {
		self.viewModel = viewModel
		super.init(isShowNavigationBar: isShowNavigationBar, navigationTitle: navigationTitle)
	}
		
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.fetchRX.onNext(())
	}

	override func setupUI() {
		super.setupUI()
		view.addSubview(tableView)
	}

	override func setupConstraints() {
		super.setupConstraints()
		tableView.snp.makeConstraints {
			$0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			$0.leading.trailing.bottom.equalToSuperview()
		}
	}

	override func setupBindings() {
		super.setupBindings()
		setupRxGeneral(viewModel: viewModel)
		
		viewModel
			.sections
			.do(afterNext: { [weak self] _ in
				guard let self else { return }
				self.tableView.refresher.endRefreshing()
			})
			.bind(to: tableView.rx.items(dataSource: dataSource))
			.disposed(by: disposeBag)

		tableView
			.rx
			.setDelegate(self)
			.disposed(by: disposeBag)
		
		tableView
			.refresher
			.rx
			.controlEvent(.valueChanged)
			.asDriver()
			.drive { [weak self] _  in
				guard let self else { return }
				self.viewModel.fetchRX.onNext(())
				self.tableView.refresher.endRefreshing()
			}.disposed(by: disposeBag)
		
		Observable
			.zip(tableView.rx.itemSelected,
				 tableView.rx.modelSelected(HomeModel.self))
			.subscribe { [weak self] (_, _) in
				guard let self else { return }
//				coordinator?.showDetail(text: item.localizedName)
			}.disposed(by: disposeBag)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension HomeViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return nil
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return .leastNonzeroMagnitude
	}

	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}

	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNonzeroMagnitude
	}
	
}
