//
//  BaseTabBarController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		delegate = self
		setupUI()
	}
	
	private func setupUI() {
		// setup selected/unselected color
		self.tabBar.tintColor = AppColors.red
		self.tabBar.unselectedItemTintColor = AppColors.white
		self.tabBar.isTranslucent = true
		self.tabBar.isOpaque = true
		self.tabBar.backgroundColor = AppColors.background
		
		let selectedItemTextColor =  AppColors.red
		let unselectedItemTextColor = AppColors.white
		let backgroundColor = AppColors.background
		
		if #available(iOS 15, *) {
			let tabBarAppearance = UITabBarAppearance()
			tabBarAppearance.backgroundColor = backgroundColor
			tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedItemTextColor]
			tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedItemTextColor]
			tabBar.standardAppearance = tabBarAppearance
			tabBar.scrollEdgeAppearance = tabBarAppearance
		} else {
			UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: selectedItemTextColor], for: .selected)
			UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: unselectedItemTextColor], for: .normal)
			tabBar.barTintColor = backgroundColor
		}
	}
	
	
	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
		guard let navController = viewController as? UINavigationController,
			  let topVC = navController.topViewController as? BaseViewController else {
			return
		}
		
		// Notify the top view controller to scroll to top
		topVC.scrollToTop()
	}
}

extension BaseTabBarController {
	enum TabBarTag: Int {
		case Home
		case Order
	}
}
