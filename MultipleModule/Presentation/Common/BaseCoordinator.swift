//
//  BaseCoordinator.swift
//  MultipleModule
//
//  Created by HieuNguyen on 13/2/25.
//

import Foundation
import UIKit
protocol Coordinator: AnyObject {
	var childCoordinators: [Coordinator] { get set }
	func start()
}

protocol CoordinatorWithNavigation: Coordinator {
	var navigationController: UINavigationController { get set }
	func start()
}

extension Coordinator {
	func addChild(_ coordinator: Coordinator) {
		childCoordinators.append(coordinator)
	}
	
	func removeChild(_ coordinator: Coordinator) {
		childCoordinators.removeAll { $0 === coordinator }
	}
	
}
