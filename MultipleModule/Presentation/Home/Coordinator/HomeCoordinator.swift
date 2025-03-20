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
	var navigationController: BaseNavigationController
	let resolver: Resolver
	
	init(resolve: Resolver,
		 navigationController: BaseNavigationController) {
		self.navigationController = navigationController
		self.resolver = resolve
	}
	
	func start() {
		let vc = resolver.resolve(HomeViewController.self)!
		vc.viewModel.fetchRX.onNext(())
		vc.coordinator = self
		vc.tabBarItem = UITabBarItem(title: "",
									 image: UIImage(named: Images.Tabbar.home.rawValue),
									 tag: TabBarCoordinator.Tag.Home.rawValue)
		navigationController.viewControllers = [vc]
	}
	
	func showDetail(model: HomeDetailElement) {
		let vc = resolver.resolve(HomeDetailViewController.self, argument: model)!
		vc.coordinator = self
		vc.hidesBottomBarWhenPushed = true
		navigationController.pushViewController(vc, animated: true)
	}
	
	func presentPopup(from vc: UIViewController) {
		let popupVC = resolver.resolve(HomePresentViewController.self)!
		vc.presentView(to: popupVC)
	}
	
	func popDetail() {
		navigationController.popViewController(animated: true)
	}
}
