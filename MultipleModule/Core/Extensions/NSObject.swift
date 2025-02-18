//
//  NSObject.swift
//  MultipleModule
//
//  Created by HieuNguyen on 19/11/24.
//

import Foundation
import UIKit

extension NSObject {
	var className: String {
		return String(describing: type(of: self))
	}

	class var className: String {
		return String(describing: self)
	}
}
