//
//  ApiTargetType.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/03/16.
//

import Foundation

enum HttpMethod:String {
	case get = "GET"
}

protocol ApiTargetType {
	var scheme:String { get }
	var host: String { get }
	var path:String { get }
	var mehtod: HttpMethod { get }
	var parameters : [String: Any] { get }
}

extension ApiTargetType {

	var scheme : String {
		return "https"
	}

	var method: HttpMethod {
		return .get
	}

	var parameter: [String: Any] {
		return [:]
	}

	func createURL(_ url: URL) -> URLRequest? {
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue
		return request
	}

	 func createCompmnents() -> URLRequest? {
		var components = URLComponents()
		components.scheme = scheme
		components.host = host
		components.path = path

		let queryItem = parameter.map { URLQueryItem(name: $0.key, value: "\($0.value)")}
		components.queryItems = queryItem

		guard let url = components.url else { return nil}

		return createURL(url)
	}
}
