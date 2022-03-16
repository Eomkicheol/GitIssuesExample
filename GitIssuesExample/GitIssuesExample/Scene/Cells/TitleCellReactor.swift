//
//  TitleCellReactor.swift
//  GitIssuesExample
//
//  Created 엄기철 on 2022/03/16.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxCocoa
import RxSwift
import ReactorKit

final class TitleCellReactor: Reactor, IdentityHashable {
	
	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
	let initialState: State 

	// MARK: Action 
	enum Action {}

	// MARK: Mutation
	enum Mutation {}

	// MARK: State
	struct State {
		var item: RepoEntities
	}

	// MARK: Initializing
	init(item: RepoEntities) {
		defer { _ = self.state }
		self.initialState = State(item: item)
	}
	
	deinit {
		DebugLog(self)
	}
}
