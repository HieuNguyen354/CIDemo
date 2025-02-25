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
	
	func setImageURLString(_ url: String,
						   placeholderImage: UIImage? = nil,
						   size: CGSize? = nil,
						   showPlaceHoleder: Bool = true) {
		guard let url = URL(string: url) else {
			image = placeholderImage
			return
		}
		
		var context = [SDWebImageContextOption: Any]()
		if let checkSize = size {
			let transformer = SDImageResizingTransformer(size: checkSize,
														 scaleMode: .aspectFill)
			context = [.imageTransformer: transformer]
		}
		self.sd_setImage(with: url,
						 placeholderImage: showPlaceHoleder ? placeholderImage : nil,
						 context: context)
	}
}
