//
//  OrderViewController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit
import RxDataSources

class OrderViewController: BaseViewController {
	
	let viewModel: OrderViewModel
	var coordinator: OrderCoordinator?
	var lastContentOffset: CGFloat = 0
	let navBarHeight: CGFloat = 44 // Approximate height of UINavigationBar
	
	private lazy var tableView: BaseTableView = {
		let tableView = BaseTableView(frame: .zero, style: .grouped)
		tableView.register(OrderViewCell.self)
		tableView.backgroundColor = AppColors.background
		tableView.contentInset = UIEdgeInsets(top: navBarHeight, left: 0, bottom: 0, right: 0)
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
	
	init(viewModel: OrderViewModel) {
		self.viewModel = viewModel
		super.init(isShowNavigationBar: true)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavigationBar()
	}
	
	override func setupUI() {
		super.setupUI()
		view.backgroundColor = AppColors.background
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
	
	func setupNavigationBar() {
		navigationController?.navigationBar.isTranslucent = true
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
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offset = scrollView.contentOffset.y + scrollView.adjustedContentInset.top
		let startOffset: CGFloat = navBarHeight // When table content reaches the navigation bar
		let maxOffset: CGFloat = 100 // Adjust to control fade/scale speed
		var alpha: CGFloat = 1
		
		if offset > startOffset {
			let progress = min(1, (offset - startOffset) / maxOffset) // Normalize progress from 0 to 1
			alpha = 1 - progress
		} else {
			alpha = 1
		}
		setNavigationBarAlpha(alpha)
		lastContentOffset = offset
	}
	
	func setNavigationBarAlpha(_ alpha: CGFloat) {
		if #available(iOS 13.0, *) {
			let navBarAppearance = UINavigationBarAppearance()
			navBarAppearance.configureWithTransparentBackground()
			navBarAppearance.backgroundColor = AppColors.white.withAlphaComponent(alpha)
			navigationController?.navigationBar.standardAppearance = navBarAppearance
			navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
		}
	}
}
