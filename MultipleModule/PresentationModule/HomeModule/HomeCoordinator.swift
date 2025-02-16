//
//  HomeCoordinator.swift
//  MultipleModule
//
//  Created by HieuNguyen on 13/2/25.
//

import UIKit
import Swinject

class HomeCoordinator: Coordinator {
	var childCoordinators = [Coordinator]()
	var navigationController: UINavigationController
	let resolver: Resolver
	
	init(navigationController: UINavigationController,
		 resolve: Resolver) {
		self.navigationController = navigationController
		self.resolver = resolve
	}
	
	func start() {
		guard let viewModel = resolver.resolve(HomeViewModel.self) else {
			fatalError("Failed to resolve HomeViewModel")
		}
		
		let homeVC = HomeViewController(isShowNavigationBar: true,
										viewModel: viewModel,
										navigationTitle: "Home")
		homeVC.coordinator = self
		homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: Images.Tabbar.Home.rawValue), tag: 0)
		
		navigationController.viewControllers = [homeVC]
	}
	
	func showDetail(text: String) {
		guard let viewModel = resolver.resolve(HomeDetailViewModel.self, argument: text) else {
			fatalError("Failed to resolve HomeViewModel")
		}
		
		let detailVC = HomeDetailViewController(isShowNavigationBar: true,
												viewModel: viewModel,
												navigationTitle: "HomeDetail")
		addChild(HomeDetailCoordinator(navigationController: navigationController, resolve: resolver))
		navigationController.pushViewController(detailVC, animated: true)
	}
}
