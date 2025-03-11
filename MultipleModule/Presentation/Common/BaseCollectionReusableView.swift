//
//  BaseCollectionReusableView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 7/3/25.
//

import UIKit
import RxSwift

class BaseCollectionReusableView: UICollectionReusableView {
	
	lazy var disposeBag = DisposeBag()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		setupConstraints()
		setupBindings()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI() { }
	func setupConstraints() { }
	func setupBindings() { }
}
