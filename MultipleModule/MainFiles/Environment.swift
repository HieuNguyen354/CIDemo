//
//  Environment.swift
//  MultipleModule
//
//  Created by HieuNguyen on 19/11/24.
//

import Foundation

struct Environment {
	private static let production: Bool = {
#if DEBUG
		//		    print("---DEBUG---")
		return false
#elseif ADHOC
		//		    print("ADHOC")
		return false
#else
		//		    print("PRODUCTION")
		return true
#endif
	}()
	
	static func isProduction () -> Bool {
		return self.production
	}
	
	static func status() -> String {
		if production {
			return "PRODUCTION"
		} else {
			return "STAGING"
		}
	}
}
