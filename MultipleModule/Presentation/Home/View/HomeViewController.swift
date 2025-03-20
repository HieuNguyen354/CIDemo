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
		let imageView = UIImageView(image: UIImage(named: Images.App.background2.rawValue)?.withRenderingMode(.alwaysOriginal))
		imageView.contentMode = .scaleAspectFill
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
		collectionView.register(HomeAttributeCollectionView.self,
								forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
								withReuseIdentifier: HomeAttributeCollectionView.className)
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
		switch item {
			case .listHero(let model):
				if let cell = collectionView.on_dequeue(HomeCell.self,
														for: indexPath) {
					cell.setData(title: model.localizedName,
								 url: model.img)
					return cell
				}
		}
		
		return collectionView.on_dequeueDefaultCell(indexPath: indexPath)
	} configureSupplementaryView: { [weak self] dataSource, collectionView, kind, indexPath in
		guard let self else {
			return UICollectionReusableView()
		}
		switch kind {
			case UICollectionView.elementKindSectionHeader:
				switch dataSource[indexPath.section].model {
					case .attributes(let model):
						if let view = collectionView.on_dequeueOfHeaderKind(HomeAttributeCollectionView.self, for: indexPath) {
							view.setData(model,
										 selectedIndex: viewModel.primaryAttrSelected.value)
							view.completionHandler = { [weak self] primaryAttr in
								guard let self else { return }
								viewModel.primaryAttrSelected.accept(primaryAttr)
							}
							return view
						}
				}
			default:
				break
		}
		return UICollectionReusableView()
	}
	
	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		super.init(isShowNavigationBar: false)
	}
	
	override func setupUI() {
		super.setupUI()
		createBlurView()
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
		
		collectionView
			.rx
			.modelSelected(HomeViewModel.SectionModelItem.self)
			.subscribe { [weak self] model in
				guard let self,
					  let model = model.element,
					  let coordinator else { return }
				switch model {
					case .listHero(let item):
						coordinator.showDetail(model: item)
				}
				
			}.disposed(by: disposeBag)
		
		collectionView
			.rx
			.setDelegate(self)
			.disposed(by: disposeBag)
	}
	
	override func scrollToTop(_ animated: Bool = true) {
		super.scrollToTop(animated)
		collectionView.setContentOffset(.init(x: -UIConstraints.normalPadding,
											  y: -(UIConstraints.normalPadding + UIConstraints.safeAreaInsets.top)),
										animated: true)
	}
	
	private func createBlurView() {
		let blurView = UIVisualEffectView()
		blurView.frame = backgroundImage.bounds
		blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // Allows resizing with the imageView
		blurView.alpha = 0.6
		UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
			blurView.effect = UIBlurEffect(style: .dark)
		}.startAnimation()
		backgroundImage.addSubview(blurView)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		switch dataSource[section].model {
			case .attributes(let model):
				let height = (model.compactMap { $0.rawValue.sizeOfString(usingFont: AppFonts.regular(size: 16)).height + UIConstraints.normalPadding*2 }.max() ?? 0) + UIConstraints.normalPadding
				return .init(width: UIConstraints.screenSize.width, height: height)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: HomeCell.originWidth,
					  height: HomeCell.originHeight * 0.75)
	}
}
