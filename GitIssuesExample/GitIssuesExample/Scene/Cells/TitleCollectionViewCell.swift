	//
	//  TitleCollectionViewCell.swift
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
import RxOptional


struct DetailDTO: Decodable {
	var html: String
	var title: String
	
	init() {
		self.title = ""
		self.html = ""
	}
}

extension Reactive where Base: TitleCollectionViewCell {
	
	var didTapped: ControlEvent<DetailDTO> {
		let source = UITapGestureRecognizer().then {
			self.base.addGestureRecognizer($0)
			self.base.isUserInteractionEnabled = true
		}.rx.event.map { [weak base] _ -> DetailDTO in
			var dto = DetailDTO()
			dto.html = base?.reactor?.currentState.item.user.html_url ?? ""
			dto.title = base?.reactor?.currentState.item.title ?? ""
			return dto
		}
		return ControlEvent(events: source)
	}
}

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
		
		
		issuesLabel.do{
			$0.setContentHuggingPriority(.required, for: .horizontal)
			$0.setContentCompressionResistancePriority(.required, for: .horizontal)
			$0.snp.makeConstraints {
				$0.centerY.equalToSuperview()
				$0.left.equalToSuperview().offset(20)
			}
		}
		
		titleLabel.do {
			$0.snp.makeConstraints {
				$0.centerY.equalToSuperview()
				$0.left.equalTo(issuesLabel.snp.right).offset(8)
				$0.right.equalTo(arrowImag.snp.left).offset(-10)
			}
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
			.asDriver(onErrorJustReturn: .init(number: 0, title: "", user: .init(html_url: "")))
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
