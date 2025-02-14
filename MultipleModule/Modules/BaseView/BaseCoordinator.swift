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
	var navigationController: UINavigationController { get set }
	
	func start()
}
