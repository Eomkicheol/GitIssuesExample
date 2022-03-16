//
//  BaseCollectionViewCell.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/03/16.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
	
	private(set) var didSetupConstraints = false
	var disposeBag = DisposeBag()
	
	var converCellSzie: CGFloat {
		return min(UIScreen.main.bounds.width, 375)
	}
	
		// MARK: Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
		// MARK: Func
	
	override func updateConstraints() {
		if !self.didSetupConstraints {
			self.setupConstraints()
			self.didSetupConstraints = true
		}
		super.updateConstraints()
	}
	
	func configure() {
		self.setNeedsUpdateConstraints()
	}
	
	func configureUI() {
		self.contentView.backgroundColor = .white
	}
	
	func setupConstraints() {}
}

