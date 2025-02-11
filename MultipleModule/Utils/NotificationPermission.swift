//
//  NotificationPermission.swift
//  MultipleModule
//
//  Created by HieuNguyen on 24/12/24.
//

//import UIKit
//import FirebaseMessaging
//
//final class NotificationPermission {
//	static var isUserAllowAuthorized: Bool {
//		get {
//			return UserDefaults.standard[#function] ?? false
//		}
//		set {
//			UserDefaults.standard[#function] = newValue
//		}
//	}
//	
//	static func checkAuthorized() {
//		UNUserNotificationCenter.current().getNotificationSettings { settings in
//			switch settings.authorizationStatus {
//				case .denied:
//					if NotificationPermission.isUserAllowAuthorized {
//					}
//					NotificationPermission.isUserAllowAuthorized = false
//				default:
//					if !NotificationPermission.isUserAllowAuthorized {
//					}
//					DispatchQueue.main.async {
//						UIApplication.shared.registerForRemoteNotifications()
//						NotificationPermission.isUserAllowAuthorized = true
//					}
//			}
//			
//			// Notification Center
//		}
//	}
//	
//}
