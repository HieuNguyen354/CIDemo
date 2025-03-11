//
//  HomeDetailViewController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit
import RxDataSources

class HomeDetailViewController: BaseViewController {
	var viewModel: HomeDetailViewModel
	var coordinator: HomeCoordinator?
	
	private lazy var tableView: BaseTableView = {
		let tableView = BaseTableView(frame: .zero, style: .grouped)
		tableView.register(HomeDetailCell.self)
		tableView.contentInsetAdjustmentBehavior = .never
		tableView.backgroundColor = AppColors.Background
		tableView.contentInset = .zero
		return tableView
	}()
	
	private lazy var presentViewButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = AppColors.Background
		button.addTarget(self, action: #selector(presentAction), for: .touchUpInside)
		return button
	}()
	
	private lazy var navBackButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = AppColors.Background
		button.setImage(UIImage(named: Images.Nav.Back.rawValue), for: .normal)
		button.addTarget(self, action: #selector(navBackAction), for: .touchUpInside)
		return button
	}()
	
	private lazy var tableHeaderView = HomeDetailTableHeaderView()
	
	typealias DataSource = RxTableViewSectionedReloadDataSource<HomeDetailViewModel.Sections>
	private lazy var dataSource = DataSource { _, tableView, indexPath, _ in
		if let cell = tableView.on_dequeue(HomeDetailCell.self, for: indexPath) {
			return cell
		}
		return tableView.on_dequeueDefaultCell()
	}
	
	init(viewModel: HomeDetailViewModel) {
		self.viewModel = viewModel
		super.init(isShowNavigationBar: false)
	}
	
	override func setupUI() {
		super.setupUI()
		presentViewButton.setTitle(viewModel.currentItem.value?.localizedName, for: .normal)
		view.backgroundColor = AppColors.Background
		view.addSubviews(tableView,
						 presentViewButton,
						 navBackButton)
	}
	
	override func setupConstraints() {
		super.setupConstraints()
		tableView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
		
		presentViewButton.snp.makeConstraints {
			$0.size.equalTo(CGSize(width: 100, height: 20))
			$0.centerX.equalToSuperview()
			$0.centerY.equalTo(navBackButton)
		}
		
		navBackButton.snp.makeConstraints {
			$0.size.equalTo(44)
			$0.leading.equalToSuperview()
			$0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
		}
	}
	
	override func setupBindings() {
		super.setupBindings()
		setupRxGeneral(viewModel: viewModel)
		
		viewModel
			.sections
			.do(afterNext: { [weak self] _ in
				guard let self else { return }
				if let value = viewModel.currentItem.value {
					tableHeaderView.setData(model: value)
				}
				tableView.tableHeaderView = tableHeaderView
				tableHeaderView.layoutIfNeeded()
				tableView.autoLayoutTableHeaderView()
			})
			.bind(to: tableView.rx.items(dataSource: dataSource))
			.disposed(by: disposeBag)
		
		tableView
			.rx
			.setDelegate(self)
			.disposed(by: disposeBag)
		
	}
	
	@objc private func navBackAction() {
		coordinator?.popDetail()
	}
	
	@objc private func presentAction() {
		coordinator?.presentPopup(from: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension HomeDetailViewController: UITableViewDelegate {
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
