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
	
	private lazy var backgroundImage: UIImageView = {
		let imageView = UIImageView(image: UIImage(named: Images.App.Background.rawValue)?.withRenderingMode(.alwaysOriginal))
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var tableView: BaseTableView = {
		let tableView = BaseTableView(frame: .zero, style: .grouped)
		tableView.register(OrderViewCell.self)
		tableView.backgroundColor = AppColors.clear
		tableView.contentInset.bottom = .zero
		return tableView
	}()
	
	typealias DataSource = RxTableViewSectionedReloadDataSource<OrderViewModel.Sections>
	private lazy var dataSource = DataSource { dataSource, tableView, indexPath, item in
		if let cell = tableView.on_dequeue(OrderViewCell.self, for: indexPath) {
			cell.backgroundColor = AppColors.clear
			cell.setData(title: item.name,
						 description: item.teamName,
						 profileURL: item.profileurl ?? "",
						 avatarURL: item.avatarfull ?? "",
						 lastMatchTime: item.lastMatchTime ?? "",
						 isHideDVL: indexPath.row == dataSource[indexPath.section].items.count - 1)
			cell.profileURLLinkTapped = { [weak self] link in
				guard let self else { return }
				if let url = URL(string: link) {
					coordinator?.openLinkURL(url: url)
				}
			}
			return cell
		}
		
		return tableView.on_dequeueDefaultCell()
	}
	
	init(viewModel: OrderViewModel) {
		self.viewModel = viewModel
		super.init(isShowNavigationBar: false)
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
		view.addSubviews(backgroundImage,
						 tableView)
	}
	
	override func setupConstraints() {
		super.setupConstraints()
		
		backgroundImage.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
		
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
	
//	func scrollViewDidScroll(_ scrollView: UIScrollView) {
//		let offset = -(scrollView.contentOffset.y)
//		let distance: CGFloat = 50
//		let percentage = offset / distance
//		let calculatePercentage = 0 - percentage
//		if calculatePercentage <= 0 {
//			setNavigationBarAlpha(min(0, calculatePercentage))
//		} else {
//			setNavigationBarAlpha(min(1, calculatePercentage))
//		}
//	}
//	
//	func setNavigationBarAlpha(_ alpha: CGFloat) {
//		if #available(iOS 13.0, *) {
//			let navBarAppearance = UINavigationBarAppearance()
//			navBarAppearance.configureWithTransparentBackground()
//			navBarAppearance.backgroundColor = AppColors.white.withAlphaComponent(alpha)
//			
//			navigationController?.navigationBar.standardAppearance = navBarAppearance
//			navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
//		}
//	}
}
