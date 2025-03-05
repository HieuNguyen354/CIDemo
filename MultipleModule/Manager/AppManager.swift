//
//  AppManager.swift
//  MultipleModule
//
//  Created by HieuNguyen on 24/12/24.
//

import UIKit
import RxSwift

class AppManager {
	static let shared = AppManager()
	
	private static let durationAnimationTabbar: TimeInterval = 0.4
	
	private(set) var currentTabbar: BaseTabBarController?
	private(set) var window: UIWindow?
	
	private init() {
	}
	
	private func setRootViewController(_ vc: UIViewController?, animated: Bool = true) {
		guard animated, let window = self.window,
			  let vc = vc else {
			return
		}
		window.backgroundColor = .clear
		if animated == true {
			window.rootViewController = vc
			window.makeKeyAndVisible()
			UIView.transition(with: window,
							  duration: AppManager.durationAnimationTabbar,
							  options: .transitionCrossDissolve,
							  animations: nil,
							  completion: nil)
		} else {
			window.rootViewController = vc
			window.makeKeyAndVisible()
		}
	}
	
	func changeTabbar(tabIndex: TabBarCoordinator.Tag? = .Home,
					  childViewController: UIViewController? = nil) {
		guard let tabIndex = tabIndex,
			  let tabbar = AppManager.shared.currentTabbar else { return }
		tabbar.selectedIndex = tabIndex.rawValue
		
		tabbar.selectedViewController?.top?.navigationController?.popToRootViewController(animated: false)
	}
	
	func resetTabbar() {
		currentTabbar = BaseTabBarController()
		currentTabbar?.selectedIndex = TabBarCoordinator.Tag.Home.rawValue
		setRootViewController(currentTabbar)
	}
}
