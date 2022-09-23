	//
	//  RepoEntities.swift
	//  GitIssuesExample
	//
	//  Created 엄기철 on 2022/03/16.
	//

import Foundation
import UIKit

struct RepoEntities: Codable, Equatable {
	var number: Int
	var title: String
	var user: UserEntities

	enum CodingKeys: String, CodingKey {
		case number
		case title
		case user
	}
}


struct UserEntities: Codable, Equatable {
	var html_url: String
}
