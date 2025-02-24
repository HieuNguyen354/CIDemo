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
	private let resolver: Resolver
	
	
	init(navigationController: UINavigationController,
		 resolve: Resolver) {
		self.navigationController = navigationController
		self.resolver = resolve
	}
	
	func start() {
		guard let viewModel = resolver.resolve(OrderViewModel.self) else { return }
		viewModel.fetchRX.onNext(())
		let orderVC = OrderViewController(isShowNavigationBar: true,
										  viewModel: viewModel,
										  navigationTitle: "ProPlayer")
		
		orderVC.tabBarItem = UITabBarItem(title: "ProPlayer",
										  image: UIImage(named: Images.Tabbar.Order.rawValue),
										  tag: 1)
		
		navigationController.viewControllers = [orderVC]
	}
}
