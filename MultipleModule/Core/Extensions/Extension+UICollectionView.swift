//
//  Extension+UICollectionView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 25/2/25.
//

import UIKit

extension UICollectionView {
	static let emptyCell = "EmptyCell"
	
	func getHeader(_ title: String) -> UIView {
		let view = UIView(frame: CGRect(x: 0,
										y: 0,
										width: self.frame.width,
										height: 80))
		
		let label = UILabel(frame: CGRect(x: 25,
										  y: 26,
										  width: self.frame.width - 50,
										  height: 26))
		label.clipsToBounds = true
		view.addSubview(label)
		view.backgroundColor = self.backgroundColor
		label.text = title
		return view
	}
	
	func scrollToNearestVisibleCollectionViewCell(cellWidth: CGFloat,
												  cellHorizontalSpacing: CGFloat) {
		self.decelerationRate = .fast
		let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
		var closestCellIndex = -1
		var closestDistance: Float = .greatestFiniteMagnitude
		for i in 0..<self.visibleCells.count {
			let cell = self.visibleCells[i]
			let cellWidth = cell.bounds.size.width
			let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
			
			// Now calculate closest cell
			let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
			if distance < closestDistance {
				closestDistance = distance
				closestCellIndex = self.indexPath(for: cell)!.row
			}
		}
		
		if closestCellIndex != -1 {
			UIView.animate(withDuration: 0.1) {
				let toX = (cellWidth + cellHorizontalSpacing + 63) * CGFloat(closestCellIndex)
				self.contentOffset = CGPoint(x: toX, y: 0)
				self.layoutIfNeeded()
			}
		}
	}
	
	func registerForHeaderKind<T: UICollectionReusableView>(_ cellTypes: [T.Type]) {
		for cellType in cellTypes {
			register(cellType,
					 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
					 withReuseIdentifier: cellType.className)
		}
	}
	
	func registerForFooterKind<T: UICollectionReusableView>(_ cellTypes: [T.Type]) {
		for cellType in cellTypes {
			register(cellType,
					 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
					 withReuseIdentifier: cellType.className)
		}
	}
	
	func register<T: BaseCollectionViewCell>(_ cellTypes: [T.Type]) {
		for cellType in cellTypes {
			register(cellType, forCellWithReuseIdentifier: cellType.className)
		}
	}
	
	func on_dequeue<T: BaseCollectionViewCell>(_ cellType: T.Type, for idxPath: IndexPath) -> T? {
		guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.className,
											 for: idxPath) as? T
		else {
			return nil
		}
		
		return cell
	}
	
	func on_dequeueOfHeaderKind<T: UICollectionReusableView>(_ type: T.Type, for idxPath: IndexPath) -> T? {
		guard let view = dequeueReusableSupplementaryView(
			ofKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: type.className,
			for: idxPath) as? T else { return nil }
		return view
	}
	
	func on_dequeueOfFooterKind<T: UICollectionReusableView>(_ type: T.Type, for idxPath: IndexPath) -> T? {
		guard let view = dequeueReusableSupplementaryView(
			ofKind: UICollectionView.elementKindSectionFooter,
			withReuseIdentifier: type.className,
			for: idxPath) as? T else { return nil }
		return view
	}
	
	func on_dequeueDefaultCell(indexPath: IndexPath) -> UICollectionViewCell {
		return dequeueReusableCell(withReuseIdentifier: UICollectionView.emptyCell,
								   for: indexPath)
	}
}
