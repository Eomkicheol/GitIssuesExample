	//
	//  HomeViewReactor.swift
	//  GitIssuesExample
	//
	//  Created 엄기철 on 2022/03/16.

import ReactorKit
import RxCocoa
import RxSwift

final class HomeViewReactor: Reactor {
	
		// MARK: Constants
	private enum Constants {
		static let imageName: String = "https://s3.ap-northeast-2.amazonaws.com/hellobot-kr-test/image/main_logo.png"
	}
	
		// MARK: Properties
	let initialState: State = State()
	
		// MARK: Initializing
	let effector: HomeViewEffectorProtocol
	
	
	
	init(effector: HomeViewEffectorProtocol) {
		self.effector = effector
	}
	
	deinit {
		DebugLog(self)
	}
	
		// MARK: Action
	enum Action {
		case fetchRepoData
	}
	
		// MARK: State
	struct State {
		var section: [RepoSection] = [.init(identity: .items, items: [])]
	}
	
		// MARK: Mutation
	enum Mutation {
		case setRepoData([RepoEntities])
	}
	
		// MARK: Mutate
	func mutate(action: Action) -> Observable<Mutation> {
		switch action {
			case .fetchRepoData:
				return self.effector
					.fetchRepoData()
					.flatMap { return Observable.just(Mutation.setRepoData($0))}
					.catchError { _ in .empty() }
		}
	}
	
		// MARK: Reduce
	func reduce(state: State, mutation: Mutation) -> State {
		var newState = state
		switch mutation {
			case .setRepoData(let items):
				
				let sectionItem: [RepoSection.Item] = items.enumerated().map { index, item in
					if index == 4 {
						return RepoSection.Item.imageItem(ImageCellReactor(imageName: Constants.imageName))
					} else {
						return RepoSection.Item.titleItem(TitleCellReactor(item: item))
					}
				}
				newState.section[0].items = sectionItem
		}
		return newState
	}
}
