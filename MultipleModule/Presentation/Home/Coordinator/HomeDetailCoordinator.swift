//
//  HomeDetailCoordinator.swift
//  MultipleModule
//
//  Created by HieuNguyen on 15/2/25.
//

import UIKit
import Swinject

class HomeDetailCoordinator: Coordinator {
	var childCoordinators: [Coordinator] = []
	var navigationController: UINavigationController
	let container: Resolver
	
	init(navigationController: UINavigationController,
		 resolve: Resolver) {
		self.navigationController = navigationController
		self.container = resolve
	}
	
	func start() {
		//
	}
	
	
}
