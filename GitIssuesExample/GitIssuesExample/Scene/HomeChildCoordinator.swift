//
//  HomeChildCoordinator.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/10/21.
//

import Foundation
import UIKit

final class HomeChildCoordinator: ChildCoordinator {

	var navigationController: UINavigationController
	weak var parentCoordinator: ParentCoordinator?

	init(with navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func configureChildViewController() {
		let respose: HomeRepositories = .init(network: Networking())
		let effector: HomeViewEffector = .init(repository: respose)
		let reactor: HomeViewReactor = .init(effector: effector)
		let viewController: HomeViewViewController = .init(reactor: reactor)
		viewController.homeChildCoordinator = self
		self.navigationController.pushViewController(viewController, animated: true)
	}

	func moveToDetailViewController(dto: DetailDTO) {
		let detailChildCoordinator = MainChildCoordinatorFactory.create(with: self.navigationController, type: .detail)
		detailChildCoordinator.parentCoordinator?.removeChildCoordinator(child: self)
		detailChildCoordinator.passParameter(value: dto)
		detailChildCoordinator.configureChildViewController()
	}
}
