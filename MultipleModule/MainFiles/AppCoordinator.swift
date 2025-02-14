//
//  AppCoordinator.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit
import RxSwift

class AppCoordinator: Coordinator {
	var childCoordinators = [Coordinator]()
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		showMainFlow()
	}
	
	private func showMainFlow() {
		let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
		childCoordinators.append(tabBarCoordinator)
		tabBarCoordinator.start()
	}
}
