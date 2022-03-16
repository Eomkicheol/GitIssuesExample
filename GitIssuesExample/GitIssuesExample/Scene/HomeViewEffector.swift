	//
	//  HomeViewEffector.swift
	//  GitIssuesExample
	//
	//  Created 엄기철 on 2022/03/16.


import RxCocoa
import RxSwift

protocol HomeViewEffectorProtocol: AnyObject {
	func fetchRepoData() -> Observable<[RepoEntities]>
}

final class HomeViewEffector: HomeViewEffectorProtocol {
	private let repository: HomeRepositoryImpl
	
	init(repository: HomeRepositoryImpl) {
		self.repository = repository
	}
	
	func fetchRepoData() -> Observable<[RepoEntities]> {
		return repository.fetchRepoData()
	}
}
