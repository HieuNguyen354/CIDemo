//
//  Extension+UIViewController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 25/2/25.
//

import UIKit

extension UIViewController {
	
	var top: UIViewController? {
		if let controller = self as? UINavigationController {
			return controller.topViewController?.top
		}
		if let controller = self as? UISplitViewController {
			return controller.viewControllers.last?.top
		}
		if let controller = self as? UITabBarController {
			return controller.selectedViewController?.top
		}
		if let controller = presentedViewController {
			return controller.top
		}
		return self
	}
	
	func presentView(to vc: UIViewController) {
		vc.modalPresentationStyle = .formSheet
		vc.modalTransitionStyle = .crossDissolve
		self.present(vc, animated: true)
	}
	
}
