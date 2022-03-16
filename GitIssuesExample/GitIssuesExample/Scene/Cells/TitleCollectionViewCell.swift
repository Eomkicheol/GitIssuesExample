	//
	//  TitleCollectionViewCell.swift
	//  GitIssuesExample
	//
	//  Created 엄기철 on 2022/03/16.
	//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
	//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit


final class TitleCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {
	
	
	typealias Reactor = TitleCellReactor
	
		// MARK: Constants
	private enum Constants { }
	
		// MARK: Propertie
	
		// MARK: UI Properties
	let issuesLabel = UILabel().then {
		$0.font = .systemFont(ofSize: 15)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	
	let titleLabel = UILabel().then {
		$0.font = .systemFont(ofSize: 15)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	
	let arrowImag = UIImageView().then {
		$0.image = UIImage(named: "icon16")
		$0.contentMode = .scaleAspectFit
		$0.clipsToBounds = true
	}
	
	
		// MARK: Initializing
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	func configure(reactor: Reactor) {
		super.configure()
		self.reactor = reactor
	}
	
	
		// MARK: UI
	override func configureUI() {
		super.configureUI()
		
		[issuesLabel, titleLabel, arrowImag].forEach {
			self.contentView.addSubview($0)
		}
	}
	
		// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
		
		issuesLabel.snp.makeConstraints {
			$0.centerY.equalToSuperview()
			$0.left.equalToSuperview().offset(20)
			
		}
		
		titleLabel.snp.makeConstraints {
			$0.centerY.equalToSuperview()
			$0.left.equalTo(issuesLabel.snp.right).offset(8)
			$0.right.lessThanOrEqualTo(arrowImag.snp.left).offset(-10)
		}
		
		arrowImag.do {
			$0.setContentHuggingPriority(.required, for: .horizontal)
			$0.setContentCompressionResistancePriority(.required, for: .horizontal)
			$0.snp.makeConstraints {
				$0.centerY.equalToSuperview()
				$0.right.equalToSuperview().offset(-20)
				$0.size.equalTo(16)
			}
		}
	}
	
		// MARK: ReactorBind
	func bind(reactor: Reactor) {
		reactor.state
			.map { $0.item }
			.asDriver(onErrorJustReturn: .init())
			.drive(onNext: { [weak self] item in
				self?.issuesLabel.text = "\(item.number) - "
				self?.titleLabel.text = item.title
			})
			.disposed(by: self.disposeBag)
	}
	
		// MARK: CellSize
	static func size(width: CGFloat) -> CGSize {
		let height: CGFloat = 0
		return CGSize(width: width, height: height)
	}
}