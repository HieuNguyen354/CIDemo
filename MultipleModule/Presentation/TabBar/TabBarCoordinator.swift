//
//  TabBarCoordinator.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit
import Swinject

class TabBarCoordinator: Coordinator {
	enum Tag: Int {
		case Home
		case Order
	}
	
	var childCoordinators = [Coordinator]()
	var tabBarController: UITabBarController
	let resolver: Resolver
	
	init(resolver: Resolver, tabBarController: UITabBarController) {
		self.tabBarController = tabBarController
		self.resolver = resolver
	}
	
	func start() {
		let homeNavController = BaseNavigationController()
		let orderNavController = BaseNavigationController()
		
		guard let homeCoordinator = resolver.resolve(HomeCoordinator.self, argument: homeNavController),
			  let orderCoordinator = resolver.resolve(OrderCoordinator.self, argument: orderNavController)
		else {
			return
		}
		
		childCoordinators.append(homeCoordinator)
		childCoordinators.append(orderCoordinator)
		
		homeCoordinator.start()
		orderCoordinator.start()
		
		tabBarController.viewControllers = [homeNavController, orderNavController]
		
		print("✅ TabBarCoordinator started successfully!")
	}
}
