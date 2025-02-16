//
//  OrderCoordinator.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit
import Swinject

class OrderCoordinator: Coordinator {
	var childCoordinators = [Coordinator]()
	var navigationController: UINavigationController
	private let container: Resolver
	
	
	init(navigationController: UINavigationController,
		 resolve: Resolver) {
		self.navigationController = navigationController
		self.container = resolve
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
