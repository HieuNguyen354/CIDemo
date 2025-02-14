//
//  OrderCoordinator.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit

class OrderCoordinator: Coordinator {
	var childCoordinators = [Coordinator]()
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let viewModel = OrderViewModel()
		let orderVC = OrderViewController(isShowNavigationBar: true,
										 viewModel: viewModel,
										 navigationTitle: "Order")
		
		orderVC.tabBarItem = UITabBarItem(title: "Order", image: UIImage(named: Images.Tabbar.Order.rawValue), tag: 1)
		navigationController.viewControllers = [orderVC]
	}
}
