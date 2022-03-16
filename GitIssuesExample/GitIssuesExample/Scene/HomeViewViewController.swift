	//
	//  HomeViewViewController.swift
	//  GitIssuesExample
	//
	//  Created 엄기철 on 2022/03/16.


import UIKit

import SnapKit
import Then
import RxViewController
import ReactorKit
import RxCocoa
import RxSwift
import ReusableKit
import RxDataSources


final class HomeViewViewController: BaseViewController, ReactorKit.View {
	
	typealias Reactor = HomeViewReactor
	
	enum Reusable {
		static let titleCell = ReusableCell<TitleCollectionViewCell>()
		static let imageCell = ReusableCell<ImageCollectionViewCell>()
	}
	
		// MARK: Constants
	private enum Constants { }
	
		// MARK: Properties
	
		// MARK: UI Properties
	lazy var rightBarButton = {
		UIBarButtonItem(title: "Search",
										style: .plain,
										target: self,
										action: #selector(rightBarButtonTapped(_:)))
	}()
	
	
	
	lazy var dataSource = self.createDataSource()
	
		// MARK: UI Properties
	lazy var collectionView = UICollectionView(
		frame: .zero,
		collectionViewLayout: UICollectionViewFlowLayout().then {
			$0.scrollDirection = .vertical
			$0.minimumLineSpacing = 0
			$0.minimumInteritemSpacing = 0
		}
	).then {
		$0.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
		$0.backgroundColor = .clear
		$0.showsHorizontalScrollIndicator = false
		$0.register(Reusable.titleCell)
		$0.register(Reusable.imageCell)
	}
	
	
		// MARK: Initializing
	init(reactor: Reactor) {
		defer {
			self.reactor = reactor
		}
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
		// MARK: View Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = rightBarButton
		self.configureNavigationITem()
	}
	
	override func configureUI() {
		super.configureUI()
		
		self.view.addSubview(collectionView)
	}
	
		// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
		
		collectionView.snp.makeConstraints {
			$0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
			$0.left.right.equalToSuperview()
			$0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
		}
	}
}

	// MARK: ReactorBind
extension HomeViewViewController {
	func bind(reactor: Reactor) {
		self.setFetchRepoItem(reactor: reactor)
		self.bindDelegate(reactor: reactor)
		
		reactor.state
			.map { $0.section }
			.distinctUntilChanged()
			.bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
			.disposed(by: self.disposeBag)
	}
}

	// MARK: Action
extension HomeViewViewController {
	
}

	// MARK: State
extension HomeViewViewController {
	private func setFetchRepoItem(reactor: Reactor) {
		self.rx.viewWillAppear
			.take(1)
			.map { _ in Reactor.Action.fetchRepoData }
			.bind(to: reactor.action)
			.disposed(by: self.disposeBag)
	}
	
	private func bindDelegate(reactor: Reactor) {
		self.collectionView.rx.setDelegate(self)
			.disposed(by: self.disposeBag)
	}
}
	
		// MARK: Func
	extension HomeViewViewController {
		@objc
		private func rightBarButtonTapped(_ sender: UIBarButtonItem) {
			print("1234")
		}
		
		private func configureNavigationITem() {
			self.navigationItem.title = "apple/swift"
			self.navigationController?.navigationBar.prefersLargeTitles = true
		}
	}
	
	
	extension HomeViewViewController {
		private func createDataSource() -> RxCollectionViewSectionedReloadDataSource<RepoSection> {
			return .init(
				configureCell: { _, collectionView, indexPath, sectionItem in
					switch sectionItem {
						case let .titleItem(cellReactor):
							let cell = collectionView.dequeue(Reusable.titleCell, for: indexPath)
							cell.configure(reactor: cellReactor)
							return cell
							
						case let .imageItem(cellReactor):
							let cell = collectionView.dequeue(Reusable.imageCell, for: indexPath)
							cell.configure(reactor: cellReactor)
							return cell
					}
				}
			)
		}
	}
	
	
	extension HomeViewViewController: UICollectionViewDelegateFlowLayout {
		func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
			return .init(width: collectionView.bounds.width, height: 33)
		}
	}
