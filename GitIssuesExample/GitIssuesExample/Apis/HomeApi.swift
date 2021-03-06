//
//  HomeApi.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/03/16.
//

import Moya

enum HomeApi {
	case fetchRepoData
	case searchRepoData(String)
}


extension HomeApi: TargetType {
	var baseURL: URL {
		guard let url = URL(string: "https://api.github.com/") else { fatalError("Bad URL Request") }
		return url
	}
	
	var path: String {
		switch self {
			case .fetchRepoData:
				return "repos/apple/swift/issues"
				
			case let .searchRepoData(search):
				return "repos/\(search)/issues"
		}
	}
	
	var method: Method {
		switch self {
			case .fetchRepoData, .searchRepoData:
				return .get
		}
	}
	
	var sampleData: Data {
		guard let data = "Data".data(using: String.Encoding.utf8) else { return Data() }
		return data
	}
	
	var task: Task {
		switch self {
			case .fetchRepoData, .searchRepoData:
				return .requestPlain
		}
	}
	
	var headers: [String : String]? {
		return [:]
	}
}
 
