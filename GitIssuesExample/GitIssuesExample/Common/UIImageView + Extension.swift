//
//  UIImageView + Extension.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/03/16.
//

import Foundation
import UIKit


private var imageDownloadDataTaskKey: Void?

extension UIImageView {
	var dataTask: Cancellable? {
		get {
			objc_getAssociatedObject(self, &imageDownloadDataTaskKey) as? Cancellable
		}
		set {
			dataTask?.cancel()
			objc_setAssociatedObject(self, &imageDownloadDataTaskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	func setImage(url: String) {
		guard let url = URL(string: url) else { return }
		dataTask = ImageLoader.shared.load(url) { [weak self] in
			self?.image = $0
		}
	}
}
