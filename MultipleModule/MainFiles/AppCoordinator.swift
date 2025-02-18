//
//  AppCoordinator.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit
import RxSwift
import Swinject

class AppCoordinator: Coordinator {
	var childCoordinators = [Coordinator]()
	var window: UIWindow
	let container: Resolver
	
	init(container: Resolver, window: UIWindow) {
		self.window = window
		self.container = container
	}
	
	func start() {
		let tabBarController = BaseTabBarController()
		guard let tabBarCoordinator = container.resolve(TabBarCoordinator.self, argument: tabBarController) else {
			fatalError("Failed to resolve TabBarCoordinator")
		}
		
		childCoordinators.append(tabBarCoordinator)
		tabBarCoordinator.start()
		
		window.rootViewController = tabBarController
		window.makeKeyAndVisible()
		
		print("✅ AppCoordinator: TabBarController set as root")
	}
	
}
