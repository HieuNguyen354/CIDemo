//
//  HomeAttributeCollectionView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 7/3/25.
//

import UIKit
import RxSwift
import RxCocoa

class HomeAttributeCollectionView: BaseCollectionViewCell {
	var completionHandler: ((PrimaryAttr) -> Void)?
	private var primaryAttr = BehaviorRelay<[PrimaryAttr]>(value: [])
	var selectedIndex: PrimaryAttr = .all
	
	private lazy var collectionView: BaseCollectionView = {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .horizontal
		flowLayout.minimumLineSpacing = 0
		flowLayout.minimumInteritemSpacing = UIConstraints.halfPadding
		
		let collectionView = BaseCollectionView(frame: .zero,
												collectionViewLayout: flowLayout)
		collectionView.register([HomeAttributeCollectionViewCell.self])
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.contentInset = .zero
		collectionView.backgroundColor = AppColors.clear
		return collectionView
	}()
	
	override func setupUI() {
		super.setupUI()
		contentView.addSubview(collectionView)
	}
	
	override func setupConstraints() {
		super.setupConstraints()
		collectionView.snp.makeConstraints {
			$0.height.equalTo(0)
			$0.leading.trailing.equalToSuperview()
			$0.top.equalToSuperview()
		}
	}
	
	override func setupBindings() {
		super.setupBindings()
		primaryAttr
			.bind(to: collectionView.rx.items) { [weak self] (collectionView, row, item) in
				let indexPath = IndexPath(row: row, section: 0)
				guard let self else { return collectionView.on_dequeueDefaultCell(indexPath: indexPath)}
				if let cell = collectionView.on_dequeue(HomeAttributeCollectionViewCell.self, for: indexPath) {
					cell.setData(title: item.rawValue,
								 selectedIndex: self.selectedIndex)
					return cell
				}
				return collectionView.on_dequeue(BaseCollectionViewCell.self, for: indexPath)!
			}.disposed(by: disposeBag)
		
		collectionView
			.rx
			.modelSelected(PrimaryAttr.self)
			.bind { [weak self] item in
				guard let self, let completionHandler else { return }
				completionHandler(item)
			}.disposed(by: disposeBag)
		
		collectionView
			.rx
			.setDelegate(self)
			.disposed(by: disposeBag)
	}
	
	func setData(_ model: [PrimaryAttr],
				 selectedIndex: PrimaryAttr) {
		primaryAttr.accept(model)
		self.selectedIndex = selectedIndex
		let height = model
			.compactMap { $0.rawValue.sizeOfString(usingFont: AppFonts.regular(size: 16)).height + UIConstraints.normalPadding*2 }
			.max() ?? 0
		collectionView.snp.updateConstraints {
			$0.height.equalTo(height)
		}
	}
	
}

extension HomeAttributeCollectionView: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let leadingPadding = UIConstraints.normalPadding
		let trailingPadding = UIConstraints.normalPadding
		let width = primaryAttr.value[indexPath.row].rawValue.sizeOfString(usingFont: AppFonts.regular(size: 16)).width + leadingPadding + trailingPadding + 8
		let height = primaryAttr.value[indexPath.row].rawValue.sizeOfString(usingFont: AppFonts.regular(size: 16)).height + leadingPadding + trailingPadding
		return CGSize(width: width,
					  height: height)
	}
}
