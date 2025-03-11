//
//  UIView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import UIKit

extension UIView {
	func appDividerLineSetup() {
		backgroundColor = AppColors.White
	}
	
	func addSubviews(_ view: UIView...) {
		view.forEach { self.addSubview($0) }
	}
}

extension UIView {
	enum Corner: Int {
		case bottomRight = 0,
			 topRight,
			 bottomLeft,
			 topLeft
	}
	
	func roundCorners(corners: [Corner] = [.topLeft,
										   .topRight,
										   .bottomLeft,
										   .bottomRight],
					  radius: CGFloat = UIConstraints.View.cornerRadius) {
		let maskedCorners: CACornerMask = CACornerMask(rawValue: createMask(corners: corners))
		clipsToBounds = true
		layer.cornerRadius = radius
		layer.maskedCorners = maskedCorners
	}
	
	private func createMask(corners: [Corner]) -> UInt {
		return corners.reduce(0, { (a, b) -> UInt in
			return a + parseCorner(corner: b).rawValue
		})
	}
	
	private func parseCorner(corner: Corner) -> CACornerMask.Element {
		let corners: [CACornerMask.Element] = [.layerMaxXMaxYCorner,
											   .layerMaxXMinYCorner,
											   .layerMinXMaxYCorner,
											   .layerMinXMinYCorner]
		return corners[corner.rawValue]
	}
}
