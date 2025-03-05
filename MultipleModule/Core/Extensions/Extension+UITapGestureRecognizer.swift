//
//  Extension+UITapGestureRecognizer.swift
//  MultipleModule
//
//  Created by HieuNguyen on 5/3/25.
//

import UIKit

extension UITapGestureRecognizer {
	func didTapAttributedText(in label: UILabel, inRange targetRange: NSRange) -> Bool {
		guard let attributedText = label.attributedText else { return false }
		
		let textStorage = NSTextStorage(attributedString: attributedText)
		let layoutManager = NSLayoutManager()
		let textContainer = NSTextContainer(size: label.bounds.size)
		textContainer.lineFragmentPadding = 0.0
		textContainer.maximumNumberOfLines = label.numberOfLines
		textContainer.lineBreakMode = label.lineBreakMode
		
		layoutManager.addTextContainer(textContainer)
		textStorage.addLayoutManager(layoutManager)
		
		let location = self.location(in: label)
		let textBoundingBox = layoutManager.usedRect(for: textContainer)
		let textOffset = CGPoint(
			x: (label.bounds.width - textBoundingBox.width) * 0.5 - textBoundingBox.origin.x,
			y: (label.bounds.height - textBoundingBox.height) * 0.5 - textBoundingBox.origin.y
		)
		
		let touchLocation = CGPoint(x: location.x - textOffset.x, y: location.y - textOffset.y)
		let index = layoutManager.characterIndex(for: touchLocation, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
		
		return NSLocationInRange(index, targetRange)
	}
}
