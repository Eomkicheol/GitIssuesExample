	//
	//  RepoEntities.swift
	//  GitIssuesExample
	//
	//  Created 엄기철 on 2022/03/16.
	//

import ObjectMapper

struct RepoEntities: Mappable  {
	var number: Int
	var title: String
	var body: String
	
	init() {
		number = 0
		title = ""
		body = ""
	}
	
	init?(map: Map) {
		number = 0
		title = ""
		body = ""
	}
	
	mutating func mapping(map: Map) {
		number <- map["number"]
		title <- map["title"]
		body <- map["body"]
	}
}
