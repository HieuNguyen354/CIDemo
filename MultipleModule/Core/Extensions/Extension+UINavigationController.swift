//
//  Extension+UINavigationController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 25/2/25.
//

import UIKit

extension UINavigationController {
	func pushView(_ viewController: UIViewController,
				  animated: Bool = true,
				  hideBottomBar: Bool = true) {
		viewController.hidesBottomBarWhenPushed = hideBottomBar
		pushViewController(viewController, animated: animated)
	}
}
