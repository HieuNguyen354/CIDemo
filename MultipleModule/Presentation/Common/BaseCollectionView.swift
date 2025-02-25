//
//  BaseCollectionView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 25/2/25.
//

import UIKit
class BaseCollectionView: UICollectionView {
	lazy var refresher: UIRefreshControl = {
		let refresher = UIRefreshControl()
		refresher.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
		self.refreshControl = refresher
		return refresher
	}()
	
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		self.backgroundColor = AppColors.backgroundOpaque
		showsHorizontalScrollIndicator = false
		showsVerticalScrollIndicator = false
		register(UICollectionViewCell.self,
				 forCellWithReuseIdentifier: UICollectionView.emptyCell)
		register(EmptyFooter.self,
				 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
				 withReuseIdentifier: EmptyFooter.className)
		register(EmptyHeader.self,
				 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
				 withReuseIdentifier: EmptyHeader.className)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class EmptyFooter: UICollectionReusableView { }

class EmptyHeader: UICollectionReusableView { }
