//
//  RepoSection.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/03/16.
//

import RxDataSources

struct RepoSection: Hashable {
	enum Identity: String {
		case items
	}
	let identity: Identity
	var items: [Item]
}

extension RepoSection: SectionModelType {
	init(original: RepoSection, items: [Item]) {
		self = RepoSection(identity: original.identity, items: items)
	}
}

extension RepoSection {
	enum Item: Hashable {
		case titleItem(TitleCellReactor)
		case imageItem(ImageCellReactor)
	}
}

extension RepoSection.Item: IdentifiableType {
	var identity: String {
		return "\(self.hashValue)"
	}
}

