//
//  HomeRouter.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/03/16.
//

import UIKit

enum HomeRouter {
	case home
	case detail(dto: DetailDTO)
}

extension HomeRouter {
	var viewController: UIViewController {
		switch self {
			case .home:
				return homeBuilder()
			case let .detail(address):
				return detailBuilder(address)
		}
	}
}


private func homeBuilder() -> UIViewController {
	let respose: HomeRepositories = .init()
	let effector: HomeViewEffector = .init(repository: respose)
	let reactor: HomeViewReactor = .init(effector: effector)
	let viewController: HomeViewViewController = .init(reactor: reactor)
	let navigationController : UINavigationController = .init(rootViewController: viewController)
	return navigationController
}


private func detailBuilder(_ dto: DetailDTO) -> UIViewController {
	let viewController: DetailViewController = .init(dto: dto)
	return viewController
}
