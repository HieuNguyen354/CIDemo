//
//  HomeCoordinator.swift
//  MultipleModule
//
//  Created by HieuNguyen on 13/2/25.
//

import UIKit

class HomeCoordinator: Coordinator {
	var childCoordinators = [Coordinator]()
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let viewModel = HomeViewModel()
		let homeVC = HomeViewController(isShowNavigationBar: true,
										viewModel: viewModel,
										navigationTitle: "Home")
		homeVC.coordinator = self
		homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: Images.Tabbar.Home.rawValue), tag: 0)
		navigationController.viewControllers = [homeVC]
	}
	
	func showDetail(text: String) {
		let viewModel = HomeDetailViewModel(text: text)
		let detailVC = HomeDetailViewController(isShowNavigationBar: true,
												viewModel: viewModel,
												navigationTitle: "HomeDetail")
		navigationController.pushViewController(detailVC, animated: true)
	}
}
