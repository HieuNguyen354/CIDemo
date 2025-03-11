//
//  BaseNavigationController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import UIKit
import Hero

class BaseNavigationController: UINavigationController {
	private var isShowBackButton: Bool = false
	private lazy var heroTransition = HeroTransition()
	
	init(isShowBackButton: Bool = false) {
		self.isShowBackButton = isShowBackButton
		super.init(nibName: nil, bundle: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		delegate = self
		
//		navigationBar.isTranslucent = false
//		navigationBar.isOpaque = false
//		navigationBar.tintColor = UIColor.red
//
		let titleTextAttributes = [
			NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
			NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.8),
			NSAttributedString.Key.backgroundColor: AppColors.White
		]

		if #available(iOS 13.0, *) {
			let appearance = UINavigationBarAppearance()
			appearance.configureWithOpaqueBackground()
			appearance.backgroundColor = AppColors.White
			appearance.titleTextAttributes = titleTextAttributes
			navigationBar.standardAppearance = appearance
			navigationBar.scrollEdgeAppearance = appearance
		} else {
			navigationBar.titleTextAttributes = titleTextAttributes
		}

		let backButton = UIBarButtonItem()
		backButton.title = ""
		navigationBar.topItem?.backBarButtonItem = backButton

		navigationBar.setBackgroundImage(UIImage(), for: .any,
										 barMetrics: .default)
		navigationBar.shadowImage = UIImage()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension BaseNavigationController: UINavigationControllerDelegate {
	
	func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
	-> UIViewControllerInteractiveTransitioning? {
		return heroTransition.navigationController(navigationController, interactionControllerFor: animationController)
	}
	
	func navigationController(_ navigationController: UINavigationController,
							  animationControllerFor operation: UINavigationController.Operation,
							  from fromVC: UIViewController,
							  to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return heroTransition.navigationController(navigationController, animationControllerFor: operation, from: fromVC, to: toVC)
	}
}
