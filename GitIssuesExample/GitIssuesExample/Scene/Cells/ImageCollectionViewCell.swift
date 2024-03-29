//
//  ImageCollectionViewCell.swift
//  GitIssuesExample
//
//  Created 엄기철 on 2022/03/16.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit

extension Reactive where Base: ImageCollectionViewCell {
	
	var didTap: ControlEvent<String> {
		let source = UITapGestureRecognizer().then {
			self.base.addGestureRecognizer($0)
			self.base.isUserInteractionEnabled = true
		}.rx.event.map { [weak base] _ in
			return base?.reactor?.currentState.webAddress
		}.filterNil()
		return ControlEvent(events: source)
	}
}


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
				self?.botImage.setImage(url: name)
			})
			.disposed(by: self.disposeBag)
	}

	// MARK: CellSize
	static func size(width: CGFloat) -> CGSize {
		let height: CGFloat = 0
		return CGSize(width: width, height: height)
	}
}
