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

	func on_dequeue<T: UITableViewCell>(_ cellType: T.Type, for idxPath: IndexPath) -> T? {
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

}
