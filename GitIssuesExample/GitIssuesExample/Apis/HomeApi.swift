	//
	//  HomeApi.swift
	//  GitIssuesExample
	//
	//  Created by 엄기철 on 2022/03/16.
	//


enum HomeApi {
	case fetchRepoData
	case searchRepoData(String)
}

extension HomeApi: ApiTargetType {
	var host: String {
		return "api.github.com"
	}

	var path: String {
		switch self {
			case .fetchRepoData:
				return "/repos/apple/swift/issues"
			case let .searchRepoData(search):
				return "/repos/\(search)/issues"
		}
	}

	var mehtod: HttpMethod {
		return .get
	}

	var parameters: [String : Any] {
		return [:]
	}
}
