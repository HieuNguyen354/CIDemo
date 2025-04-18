//
//  BaseCollectionViewCell.swift
//  MultipleModule
//
//  Created by HieuNguyen on 25/2/25.
//

import UIKit
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
	var disposeBag = DisposeBag()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		setupConstraints()
		setupBindings()
	}
	
	func setupUI() { }
	func setupConstraints() { }
	func setupBindings() { }
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
