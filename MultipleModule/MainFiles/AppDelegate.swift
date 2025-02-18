//
//  AppDelegate.swift
//  MultipleModule
//
//  Created by HieuNguyen on 11/2/25.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	var appCoordinator: AppCoordinator?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		setupRootViewController()
		ClientManager.start()
		return true
	}
	
	private func setupRootViewController() {
		window = UIWindow()
		guard let window else { return }
		let container = AppDICoordinator.shared.container
		print("✅ Initializing AppCoordinator...")
		guard let appCoordinator = container.resolve(AppCoordinator.self,
													 argument: window)
		else {
			return
		}
		self.appCoordinator = appCoordinator
		appCoordinator.start()
	}
}
