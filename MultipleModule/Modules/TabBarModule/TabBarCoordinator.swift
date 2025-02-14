//
//  TabBarCoordinator.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit

class TabBarCoordinator: Coordinator {
	var childCoordinators = [Coordinator]()
	var navigationController: UINavigationController
	var tabBarController: UITabBarController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.tabBarController = UITabBarController()
	}
	
	func start() {
		setupUI()
		navigationController.setNavigationBarHidden(true, animated: false)
		let homeNavController = BaseNavigationController()
		let orderNavController = BaseNavigationController()
		
		let homeCoordinator = HomeCoordinator(navigationController: homeNavController)
		let orderCoordinator = OrderCoordinator(navigationController: orderNavController)
		
		childCoordinators.append(homeCoordinator)
		childCoordinators.append(orderCoordinator)
		
		homeCoordinator.start()
		orderCoordinator.start()
		
		tabBarController.viewControllers = [homeNavController, orderNavController]
		
		
		navigationController.viewControllers = [tabBarController]
	}
	
	private func setupUI() {
		// setup selected/unselected color
		tabBarController.tabBar.tintColor = UIColor.black
		tabBarController.tabBar.unselectedItemTintColor = UIColor.black.withAlphaComponent(0.7)
		tabBarController.tabBar.isTranslucent = false
		tabBarController.tabBar.isOpaque = false
		
		let selectedItemTextColor = UIColor.black
		let unselectedItemTextColor = UIColor.black.withAlphaComponent(0.7)
		let backgroundColor = UIColor.white
		
		if #available(iOS 15, *) {
			let tabBarAppearance = UITabBarAppearance()
			tabBarAppearance.backgroundColor = backgroundColor
			tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedItemTextColor]
			tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedItemTextColor]
			tabBarController.tabBar.standardAppearance = tabBarAppearance
			tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
		} else {
			UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: selectedItemTextColor], for: .selected)
			UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: unselectedItemTextColor], for: .normal)
			tabBarController.tabBar.barTintColor = backgroundColor
		}
	}
}
