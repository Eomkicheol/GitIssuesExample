//
//  ImageCollectionViewCell.swift
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
import Kingfisher


final class ImageCollectionViewCell: BaseCollectionViewCell, ReactorKit.View {

	typealias Reactor = ImageCellReactor

	// MARK: Constants
	private enum Constants { }

	// MARK: Propertie

	// MARK: UI Properties
	let botImage = UIImageView().then {
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
		self.contentView.addSubview(botImage)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
		botImage.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}

	// MARK: ReactorBind
	func bind(reactor: Reactor) {
		reactor.state
			.map { $0.imageName }
			.asDriver(onErrorJustReturn: "")
			.drive(onNext: { [weak self] name in
				guard let url = URL(string: name) else { return }
				self?.botImage.kf.setImage(with: url)
			})
			.disposed(by: self.disposeBag)
	}

	// MARK: CellSize
	static func size(width: CGFloat) -> CGSize {
		let height: CGFloat = 0
		return CGSize(width: width, height: height)
	}
}
