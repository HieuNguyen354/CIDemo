//
//  CGFloat.swift
//  MultipleModule
//
//  Created by HieuNguyen on 10/2/25.
//

import UIKit

struct UIConstraints {
	static let screenSize: CGRect = UIScreen.main.bounds
	static let normalPadding: CGFloat = 16
	static let halfPadding: CGFloat = 8
	static let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? .zero
	static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
	static let tabBarHeight = UITabBarController().tabBar.frame.height
	static let navigationBarHeight = UINavigationBar.appearance().frame.height
	
	static func calculateRatioSize(originWidth: CGFloat,
								   originHeight: CGFloat,
								   ratioWidth: CGFloat) -> CGSize {
		let ratio = originWidth / originHeight
		return CGSize(width: ratioWidth,
					  height: ratioWidth / ratio)
	}
	
	struct View {
		static let smallCornerRadius: CGFloat = 4
		static let cornerRadius: CGFloat = 8
	}
}
