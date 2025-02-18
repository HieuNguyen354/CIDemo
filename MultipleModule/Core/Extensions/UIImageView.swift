//
//  UIImageView.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import UIKit
import SDWebImage

extension UIImageView {
	func load(url: URL?) {
		guard let url else { return }
		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
	
	func makeRounded() {
		let radius = self.frame.width/2.0
		self.layer.cornerRadius = radius
		self.layer.masksToBounds = true
		clipsToBounds = true
	}
}
