//
//  PushNotificationService.swift
//  MultipleModule
//
//  Created by HieuNguyen on 14/1/25.
//
//
//import UserNotifications
//import FirebaseMessaging
//import FirebaseCore
//
//class PushNotificationService: NSObject {
//	
//	private(set) static var shared = PushNotificationService()
//	private let center = UNUserNotificationCenter.current()
//	
//	private override init() {
//		super.init()
//		setupRemoteNotification()
//	}
//	
//	static func setup() {
//		_ = PushNotificationService.shared
//	}
//	
//	private func setupRemoteNotification() {
//		center.delegate = self
//		center.requestAuthorization(options: [.alert, .badge, .sound]) { (authenticated, error) in
//			if let error {
//				print(error)
//			}
//			
//			NotificationPermission.checkAuthorized()
//		}
//	}
//}
//
//extension PushNotificationService: UNUserNotificationCenterDelegate {
//	func userNotificationCenter(
//		_ center: UNUserNotificationCenter,
//		willPresent notification: UNNotification,
//		withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
//	) {
//		let userInfo = notification.request.content.userInfo
//		Messaging.messaging().appDidReceiveMessage(userInfo)
////		switch UIApplication.shared.applicationState {
////			case .active:
////				break
////			case .background:
////				break
////			default:
////				completionHandler([.sound, .badge])
////		}
//		completionHandler(.banner)
//	}
//	
//	func userNotificationCenter(
//		_ center: UNUserNotificationCenter,
//		didReceive response: UNNotificationResponse,
//		withCompletionHandler completionHandler: @escaping () -> Void
//	) {
//		let notification = response.notification
//		switch UIApplication.shared.applicationState {
//			case .active:
//				break
//			case .inactive:
//				break
//			case .background:
//				break
//			default: break
//		}
//		
//		completionHandler()
//	}
//}
