//
//  BaseAlertBuilder.swift
//  MultipleModule
//
//  Created by HieuNguyen on 19/2/25.
//

import UIKit

class BaseAlertBuilder: NSObject {
	
	struct AlertButton {
		var index: Int
		var title: String
		var style: UIAlertAction.Style = .default
	}
	
	typealias NVAlertBuilderCompletion = (Int) -> Void
	
	private var alertTitle = ""
	private var alertMessage = ""
	private var alertButtons = [AlertButton]()
	private var alertRootVC: UIViewController?
	private var alertStyle: UIAlertController.Style = .alert
	
	func title(title: String) -> BaseAlertBuilder {
		alertTitle = title
		return self
	}
	
	func message(message: String) -> BaseAlertBuilder {
		alertMessage = message
		return self
	}
	
	func buttons(titles: [AlertButton]) -> BaseAlertBuilder {
		alertButtons = titles
		return self
	}
	
	func parentViewController(rootVC: UIViewController) -> BaseAlertBuilder {
		alertRootVC = rootVC
		return self
	}
	
	func setupAlertStyle(style: UIAlertController.Style) -> BaseAlertBuilder {
		alertStyle = style
		return self
	}
	
	func showAlert(completion: NVAlertBuilderCompletion? = nil) {
		let alertView = UIAlertController(title: alertTitle,
										  message: alertMessage,
										  preferredStyle: alertStyle)
		for alertButton in alertButtons {
			alertView.addAction(UIAlertAction(title: alertButton.title,
											  style: alertButton.style,
											  handler: { _ in
				completion?(alertButton.index)
			}))
		}
		
		alertRootVC?.present(alertView, animated: true, completion: nil)
	}
	
}
