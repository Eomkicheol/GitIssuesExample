//
//  ImageLoader.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/03/16.
//

import UIKit

protocol Cancellable {
	func cancel()
}

final class CancellableWrapper: Cancellable {
	var cancellable: Cancellable?
	private(set) var isCancelled: Bool = false

	func cancel() {
		guard let cancellable = self.cancellable else { return }

		isCancelled = true
		cancellable.cancel()
	}
}

extension URLSessionDataTask: Cancellable {}

final class ImageLoader {
	 static let shared = ImageLoader()

	private let cache = NSCache<NSString, UIImage>()

	private init() {}

	func load(_ url: URL, completion: @escaping (UIImage?) -> Void) -> Cancellable {

		let key = NSString(string: url.absoluteString)

		if let image = cache.object(forKey: key) {
			completion(image)
		}

		let cancelable = CancellableWrapper()

		let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
			guard let data = data, let image = UIImage(data: data) else {
				DispatchQueue.main.async {
					completion(nil)
				}
				return
			}
			DispatchQueue.main.async {
				self?.cache.setObject(image, forKey: key)
				completion(!cancelable.isCancelled ? image : nil)
			}
		}

		dataTask.resume()

		cancelable.cancellable = dataTask
		return cancelable
	}
}
