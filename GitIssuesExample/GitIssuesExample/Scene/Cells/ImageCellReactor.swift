//
//  ImageCellReactor.swift
//  GitIssuesExample
//
//  Created 엄기철 on 2022/03/16.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxCocoa
import RxSwift
import ReactorKit

final class ImageCellReactor: Reactor, IdentityHashable {
	
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
		let imageName: String
	}

	// MARK: Initializing
	init(imageName: String) {
		defer { _ = self.state }
		self.initialState = State(imageName: imageName)
	}
	
	deinit {
		DebugLog(self)
	}
}
