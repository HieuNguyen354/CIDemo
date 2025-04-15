//
//  HomeSideMenuViewController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/4/25.
//

import UIKit

class HomeSideMenuViewController: BaseViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .darkGray
		
		let label = UILabel()
		label.text = "Side Menu"
		label.textColor = .white
		label.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(label)
		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
}
