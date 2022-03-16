//
//  HomeRepositories.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/03/16.
//

import Moya
import RxSwift
import RxCocoa

protocol HomeRepositoryImpl: AnyObject {
	func fetchRepoData() -> Observable<[RepoEntities]>
	func searchRepoData(searchName: String) -> Observable<[RepoEntities]>
}

final class HomeRepositories: HomeRepositoryImpl {
	
	private let network: NetworkingProtocol
	
	init(network: NetworkingProtocol = defaultNetwork) {
		self.network = network
	}
	
	func fetchRepoData() -> Observable<[RepoEntities]> {
		return network.request(HomeApi.fetchRepoData)
			.asObservable()
			.mapString()
			.compactMap { value -> [RepoEntities] in
				if let jsonModel = [RepoEntities](JSONString: value) {
					return jsonModel
				}
				return [RepoEntities]()
			}
	}
	
	
	func searchRepoData(searchName: String) -> Observable<[RepoEntities]> {
		return network.request(HomeApi.searchRepoData(searchName))
			.asObservable()
			.mapString()
			.compactMap { value -> [RepoEntities] in
				if let jsonModel = [RepoEntities](JSONString: value) {
					return jsonModel
				}
				return [RepoEntities]()
			}
	}
}
