//
//  MainChildCoordinatorFactory.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/10/21.
//

import Foundation
import UIKit


enum ChildCoordinatorType {
	case home
	case detail
}

final class MainChildCoordinatorFactory {
	static func create(with navigationController: UINavigationController,
										 type: ChildCoordinatorType) -> ChildCoordinator {
		switch type {
			case .home:
				return HomeChildCoordinator(with: navigationController)
			case .detail:
				return DetailChildCoordinator(with: navigationController)
		}
	}
}
