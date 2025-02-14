//
//  AppDelegate.swift
//  MultipleModule
//
//  Created by HieuNguyen on 11/2/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	private var appCoordinator: AppCoordinator!
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		setupRootViewController()
		ClientManager.start()
		return true
	}
		
	private func setupRootViewController() {
		
		window = UIWindow()
		let navController = UINavigationController()
		appCoordinator = AppCoordinator(navigationController: navController)
		appCoordinator?.start()
		
		window?.rootViewController = navController
		window?.makeKeyAndVisible()
	}
}
