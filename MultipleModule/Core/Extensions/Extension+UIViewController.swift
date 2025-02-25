//
//  Extension+UIViewController.swift
//  MultipleModule
//
//  Created by HieuNguyen on 25/2/25.
//

import UIKit

extension UIViewController {
	func presentView(to vc: UIViewController) {
		vc.modalPresentationStyle = .formSheet
		vc.modalTransitionStyle = .crossDissolve
		self.present(vc, animated: true)
	}
}
