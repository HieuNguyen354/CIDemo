//
//  UITableView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 19/11/24.
//

import UIKit

extension UITableView {
	static let emptyCell = "EmptyCell"

	func register<T: UITableViewCell>(_ cellTypes: T.Type...) {
		for cellType in cellTypes {
			register(cellType, forCellReuseIdentifier: cellType.className)
		}
	}

	func on_dequeue<T: BaseTableViewCell>(_ cellType: T.Type, for idxPath: IndexPath) -> T? {
		guard let cell = dequeueReusableCell(
			withIdentifier: cellType.className,
			for: idxPath
		) as? T else {
			return nil
		}

		return cell
	}

	func on_dequeueDefaultCell() -> UITableViewCell {
		return dequeueReusableCell(withIdentifier: UITableView.emptyCell)!
	}
	
	func autoLayoutTableHeaderView() {
		guard let headerView = self.tableHeaderView else { return }
		headerView.translatesAutoresizingMaskIntoConstraints = false
		
		let headerWidth = headerView.bounds.size.width
		let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
		
		headerView.addConstraints(temporaryWidthConstraints)
		
		headerView.setNeedsLayout()
		headerView.layoutIfNeeded()
		
		let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		let height = headerSize.height
		var frame = headerView.frame
		
		frame.size.height = height
		headerView.frame = frame
		
		self.tableHeaderView = headerView
		
		headerView.removeConstraints(temporaryWidthConstraints)
		headerView.translatesAutoresizingMaskIntoConstraints = true
	}

}
