//
//  TabBarCoordinator.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit
import Swinject

class TabBarCoordinator: Coordinator {
	var childCoordinators = [Coordinator]()
	var tabBarController: UITabBarController
	let resolver: Resolver
	
	init(resolver: Resolver, tabBarController: UITabBarController) {
		self.tabBarController = tabBarController
		self.resolver = resolver
	}
	
	func start() {
		print("✅ TabBarCoordinator started")
		let homeNavController = BaseNavigationController()
		let orderNavController = BaseNavigationController()
		
		guard let homeCoordinator = resolver.resolve(HomeCoordinator.self, argument: homeNavController),
			  let orderCoordinator = resolver.resolve(OrderCoordinator.self, argument: orderNavController)
		else {
			fatalError("Failed to resolve HomeCoordinator or OrderCoordinator")
		}
		
		childCoordinators.append(homeCoordinator)
		childCoordinators.append(orderCoordinator)
		
		homeCoordinator.start()
		orderCoordinator.start()
		
		tabBarController.viewControllers = [homeNavController]
		
		print("✅ TabBarCoordinator started successfully!")
		print("✅ TabBarCoordinator: Tab bar has \(tabBarController.viewControllers?.count ?? 0) controllers")
	}
}
