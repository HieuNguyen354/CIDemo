//
//  OrderViewController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit
import RxDataSources

class OrderViewController: BaseViewController {
	private let viewModel: OrderViewModel
	
	private lazy var tableView: BaseTableView = {
		let tableView = BaseTableView(frame: .zero, style: .grouped)
		tableView.register(OrderViewCell.self)
		return tableView
	}()
	
	typealias DataSource = RxTableViewSectionedReloadDataSource<OrderViewModel.Sections>
	private lazy var dataSource = DataSource { dataSource, tableView, indexPath, item in
		if let cell = tableView.on_dequeue(OrderViewCell.self, for: indexPath) {
			cell.setData(title: item.name,
						 description: item.teamName,
						 profileURL: item.profileurl ?? "",
						 avatarURL: item.avatarfull ?? "",
						 isHideDVL: indexPath.row == dataSource[indexPath.section].items.count - 1)
			return cell
		}
		
		return tableView.on_dequeueDefaultCell()
	}
	
	init(isShowNavigationBar: Bool,
		 viewModel: OrderViewModel,
		 navigationTitle: String) {
		self.viewModel = viewModel
		super.init(isShowNavigationBar: isShowNavigationBar, navigationTitle: navigationTitle)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
			$0.edges.equalToSuperview()
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
			.refresher
			.rx
			.controlEvent(.valueChanged)
			.asDriver()
			.drive { [weak self] _  in
				guard let self else { return }
				self.viewModel.fetchRX.onNext(())
				self.tableView.refresher.endRefreshing()
			}.disposed(by: disposeBag)
		
		tableView
			.rx
			.setDelegate(self)
			.disposed(by: disposeBag)
		
	}
}

extension OrderViewController: UITableViewDelegate {
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
