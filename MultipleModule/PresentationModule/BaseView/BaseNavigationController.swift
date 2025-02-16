//
//  BaseNavigationController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit

class BaseNavigationController: UINavigationController {
	private var isShowBackButton: Bool = false
	
	init(isShowBackButton: Bool = false) {
		self.isShowBackButton = isShowBackButton
		super.init(nibName: nil, bundle: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBar.isTranslucent = false
		navigationBar.isOpaque = false
		navigationBar.tintColor = UIColor.white

		let titleTextAttributes = [
			NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
			NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.8),
			NSAttributedString.Key.backgroundColor: UIColor.white
		]

		if #available(iOS 13.0, *) {
			let appearance = UINavigationBarAppearance()
			appearance.configureWithOpaqueBackground()
			appearance.backgroundColor = UIColor.white
			appearance.titleTextAttributes = titleTextAttributes
			navigationBar.standardAppearance = appearance
			navigationBar.scrollEdgeAppearance = appearance
		} else {
			navigationBar.titleTextAttributes = titleTextAttributes
		}

		if isShowBackButton == true {
			let backButton = UIBarButtonItem()
			backButton.title = ""
			navigationBar.topItem?.backBarButtonItem = backButton
		} else {
			navigationBar.topItem?.backBarButtonItem = nil
		}

		navigationBar.setBackgroundImage(UIImage(), for: .any,
										 barMetrics: .default)
		navigationBar.shadowImage = UIImage()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
