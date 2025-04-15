//
//  Extension+Data.swift
//  MultipleModule
//
//  Created by HieuNguyen on 15/4/25.
//

import UIKit

extension Data {
	func photoData(data: Data, boundary: String, fileName: String) -> Self {
		let fullData = NSMutableData()
		
		// 1 - Boundary should start with --
		let lineOne = "--" + boundary + "\r\n"
		if let lineData = lineOne.data(using: .utf8, allowLossyConversion: false) {
			fullData.append(lineData)
		}
		
		// 2
		let lineTwo = "Content-Disposition: form-data; name=\"file\"; filename=\"" + fileName + "\"\r\n"
		if let lineData = lineTwo.data(using: .utf8, allowLossyConversion: false) {
			fullData.append(lineData)
		}
		
		// 3
		let lineThree = "Content-Type: image/jpg\r\n\r\n"
		if let lineData = lineThree.data(using: .utf8, allowLossyConversion: false) {
			fullData.append(lineData)
		}
		
		// 4
		fullData.append(data as Data)
		
		// 5
		let lineFive = "\r\n"
		if let lineData = lineFive.data(using: .utf8, allowLossyConversion: false) {
			fullData.append(lineData)
		}
		
		// 6 - The end. Notice -- at the start and at the end
		let lineSix = "--" + boundary + "--\r\n"
		if let lineData = lineSix.data(using: .utf8, allowLossyConversion: false) {
			fullData.append(lineData)
		}
		
		return Data(referencing: fullData)
	}
}
