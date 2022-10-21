//
//  MainCoordinator.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/10/21.
//

import Foundation
import UIKit

final class MainCoordinator: ParentCoordinator {
	var navigationController: UINavigationController

	var childCoordinator: [ChildCoordinator] = [ChildCoordinator]()

	init(with navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func configureRootViewController() {
		let homeChildCoordinator = MainChildCoordinatorFactory.create(with: self.navigationController, type: .home)
		childCoordinator.append(homeChildCoordinator)
		homeChildCoordinator.parentCoordinator = self
		homeChildCoordinator.configureChildViewController()
	}

	func removeChildCoordinator(child: ChildCoordinator) {
		for(index, coordinator) in childCoordinator.enumerated() {
			if coordinator === child {
				childCoordinator.remove(at: index)
				break
			}
		}
	}
}
