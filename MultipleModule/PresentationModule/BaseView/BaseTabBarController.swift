//
//  BaseTabBarController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/2/25.
//

import UIKit

class BaseTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupTabBarItems()
	}
	
	private func setupUI() {
		// setup selected/unselected color
		self.tabBar.tintColor = UIColor.black
		self.tabBar.unselectedItemTintColor = UIColor.black.withAlphaComponent(0.7)
		self.tabBar.isTranslucent = false
		self.tabBar.isOpaque = false
		
		let selectedItemTextColor = UIColor.black
		let unselectedItemTextColor = UIColor.black.withAlphaComponent(0.7)
		let backgroundColor = UIColor.white
		
		if #available(iOS 15, *) {
			let tabBarAppearance = UITabBarAppearance()
			tabBarAppearance.backgroundColor = backgroundColor
			tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedItemTextColor]
			tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedItemTextColor]
			tabBar.standardAppearance = tabBarAppearance
			tabBar.scrollEdgeAppearance = tabBarAppearance
		} else {
			UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: selectedItemTextColor], for: .selected)
			UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: unselectedItemTextColor], for: .normal)
			tabBar.barTintColor = backgroundColor
		}
	}
	
	private func setupTabBarItems() {
//		let home = BaseNavigationController(rootViewController: HomeViewController(isShowNavigationBar: false,
//																				   navigationTitle: "Home"))
//		home.tabBarItem = UITabBarItem(title: "Home".txt,
//									   image: UIImage(named: Images.Tabbar.Home.rawValue),
//									   tag: TabBarTag.Home.rawValue)
//		home.title = "Home".txt
//		
//		let order = BaseNavigationController(rootViewController: OrderViewController(isShowNavigationBar: false,
//																					 navigationTitle: "Order"))
//		order.tabBarItem = UITabBarItem(title: "Order".txt,
//										image: UIImage(named: Images.Tabbar.Order.rawValue),
//										tag: TabBarTag.Order.rawValue)
//		order.title = "Order".txt
//		
//		viewControllers = [home, order]
	}
	
}

extension BaseTabBarController {
	enum TabBarTag: Int {
		case Home
		case Order
	}
}
