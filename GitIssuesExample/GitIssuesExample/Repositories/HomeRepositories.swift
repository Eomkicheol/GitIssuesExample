//
//  HomeRepositories.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/03/16.
//

import RxSwift
import RxCocoa

protocol HomeRepositoryImpl: AnyObject {
	func fetchRepoData() -> Observable<[RepoEntities]>
	func searchRepoData(searchName: String) -> Observable<[RepoEntities]>
}

final class HomeRepositories: HomeRepositoryImpl {
	
	private let network: NetworkingProtocol
	
	init(network: NetworkingProtocol) {
		self.network = network
	}
	
	func fetchRepoData() -> Observable<[RepoEntities]> {
		return network.request(HomeApi.fetchRepoData)
			.asObservable()
	}
	
	
	func searchRepoData(searchName: String) -> Observable<[RepoEntities]> {
		return network.request(HomeApi.searchRepoData(searchName))
			.asObservable()
	}
}
