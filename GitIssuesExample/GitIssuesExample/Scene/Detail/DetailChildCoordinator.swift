//
//  DetailChildCoordinator.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/10/21.
//

import Foundation
import UIKit

final class DetailChildCoordinator: ChildCoordinator {

	weak var parentCoordinator: ParentCoordinator?
	var navigationController: UINavigationController
	private(set) var dto: DetailDTO = .init()

	init(with navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func configureChildViewController() {
		let viewController = DetailViewController(dto: self.dto)
		self.navigationController.pushViewController(viewController, animated: true)
	}

	func passParameter(value: Decodable) {
		guard let dto = value as? DetailDTO else { return }
		self.dto = dto
	}
}
