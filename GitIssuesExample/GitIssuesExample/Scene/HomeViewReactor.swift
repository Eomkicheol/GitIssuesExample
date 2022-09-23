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
		case moveToWeb(String)
		case moveToDetail(DetailDTO)
		case searchRepo(String)
	}
	
		// MARK: State
	struct State {
		var section: [RepoSection] = [.init(identity: .items, items: [])]
		var moveToWeb: String?
		var moveToDetail: DetailDTO?
		var errorMessage: String?
	}
	
		// MARK: Mutation
	enum Mutation {
		case setRepoData([RepoEntities])
		case setMoveToWeb(String?)
		case setMoveToDetail(DetailDTO?)
		case setSearchRepo([RepoEntities])
		case setErrorMessage(String?)
	}
	
		// MARK: Mutate
	func mutate(action: Action) -> Observable<Mutation> {
		switch action {
			case .fetchRepoData:
				return self.effector
					.fetchRepoData()
					.flatMap { return Observable.just(Mutation.setRepoData($0))}
					.catch { _ in .empty() }
			case let .moveToWeb(address):
				return Observable.concat([
					Observable.just(Mutation.setMoveToWeb(address)),
					Observable.just(Mutation.setMoveToWeb(nil)),
				])
				
			case let .moveToDetail(dto):
				return Observable.concat([
					Observable.just(Mutation.setMoveToDetail(dto)),
					Observable.just(Mutation.setMoveToDetail(nil)),
				])
				
			case .searchRepo(let search):
				return self.effector
					.searchRepoData(searchName: search)
					.flatMap { return Observable.just(Mutation.setRepoData($0))}
					.catch { _  -> Observable<Mutation> in
						return Observable.concat([
							Observable.just(Mutation.setErrorMessage("검색하신 레포가 없습니다.")),
							Observable.just(Mutation.setErrorMessage(nil))
						])
					}
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
				
			case .setMoveToWeb(let address):
				newState.moveToWeb = address
			
			case .setMoveToDetail(let dto):
				newState.moveToDetail = dto
				
			case .setSearchRepo(let item):
				let titleCellReactor  = item.map { item -> TitleCellReactor in
					return TitleCellReactor(item: item)
				}
				
				
			newState.section[0].items = titleCellReactor.map(RepoSection.Item.titleItem)
			
			case .setErrorMessage(let message):
				newState.errorMessage = message
		}
		return newState
	}
}
