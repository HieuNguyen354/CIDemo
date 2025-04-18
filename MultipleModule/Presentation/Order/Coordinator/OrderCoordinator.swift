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
	
	init(resolve: Resolver,
		 navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.resolver = resolve
	}
	
	func start() {
		let vc = resolver.resolve(OrderViewController.self)!
		vc.viewModel.fetchRX.onNext(())
		vc.coordinator = self
		vc.tabBarItem = UITabBarItem(title: "",
									 image: UIImage(named: Images.Tabbar.order.rawValue),
									 tag: TabBarCoordinator.Tag.Order.rawValue)
		navigationController.viewControllers = [vc]
	}
	
	func openLinkURL(url: URL) {
		UIApplication.shared.open(url)
	}
}
