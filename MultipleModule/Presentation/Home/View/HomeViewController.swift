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
	var viewModel: HomeViewModel!
	var coordinator: HomeCoordinator?
	
	private lazy var backgroundImage: UIImageView = {
		let imageView = UIImageView(image: UIImage(named: Images.App.Background1.rawValue)?.withRenderingMode(.alwaysOriginal))
		imageView.clipsToBounds = true
		return imageView
	}()

	private lazy var collectionView: BaseCollectionView = {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .vertical
		flowLayout.itemSize = CGSize(width: HomeCell.originWidth,
									 height: HomeCell.originHeight * 0.75)
		flowLayout.minimumLineSpacing = UIConstraints.halfPadding
		flowLayout.minimumInteritemSpacing = 0
		
		let collectionView = BaseCollectionView(frame: .zero,
												collectionViewLayout: flowLayout)
		collectionView.register([HomeCell.self])
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.contentInset = .init(top: UIConstraints.normalPadding,
											left: UIConstraints.normalPadding,
											bottom: 0,
											right: UIConstraints.normalPadding)
		collectionView.backgroundColor = AppColors.clear
		return collectionView
	}()

	typealias DataSource = RxCollectionViewSectionedReloadDataSource<HomeViewModel.Sections>
	private lazy var dataSource = DataSource { _, collectionView, indexPath, item in
		if let cell = collectionView.on_dequeue(HomeCell.self, for: indexPath) {
			cell.setData(title: item.localizedName, url: item.img)
			return cell
		}
		
		return collectionView.on_dequeueDefaultCell(indexPath: indexPath)
	}
	
	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		super.init(isShowNavigationBar: false)
	}
	
	override func setupUI() {
		super.setupUI()
		view.backgroundColor = AppColors.background
		view.addSubviews(backgroundImage,
						 collectionView)
	}
	
	override func setupConstraints() {
		super.setupConstraints()
		
		backgroundImage.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
		
		collectionView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}

	override func setupBindings() {
		super.setupBindings()
		setupRxGeneral(viewModel: viewModel)
		
		viewModel
			.sections
			.do(afterNext: { [weak self] (_) in
				guard let self else { return }
				self.collectionView.refresher.endRefreshing()
			})
			.bind(to: collectionView.rx.items(dataSource: dataSource))
			.disposed(by: disposeBag)

		collectionView
			.refresher
			.rx
			.controlEvent(.valueChanged)
			.asDriver()
			.drive { [weak self] _  in
				guard let self else { return }
				self.viewModel.fetchRX.onNext(())
				self.collectionView.refresher.endRefreshing()
			}.disposed(by: disposeBag)
		
		Observable
			.zip(collectionView.rx.itemSelected,
				 collectionView.rx.modelSelected(HomeDetailElement.self))
			.subscribe { [weak self] (_, item) in
				guard let self else { return }
				coordinator?.showDetail(model: item)
			}.disposed(by: disposeBag)
	}
	
	override func scrollToTop(_ animated: Bool = true) {
		super.scrollToTop(animated)
		collectionView.setContentOffset(.init(x: -UIConstraints.normalPadding,
											  y: -(UIConstraints.normalPadding + UIConstraints.safeAreaInsets.top)),
										animated: true)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
