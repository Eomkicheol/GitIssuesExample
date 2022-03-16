//
//  DetailViewController.swift
//  GitIssuesExample
//
//  Created 엄기철 on 2022/03/16.
//

import UIKit
import WebKit

import SnapKit
import Then

final class DetailViewController: BaseViewController, WKNavigationDelegate {


	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
	let dto: DetailDTO
	
	// MARK: UI Properties
	lazy var webView = WKWebView().then {
		$0.navigationDelegate = self
	}


	// MARK: Initializing
	init(dto: DetailDTO) {
		self.dto = dto
		super.init()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: View Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let url = URL(string: self.dto.html) else { return }
		self.title = self.dto.title
		
		webView.load(URLRequest(url: url))
	}

	override func configureUI() {
		super.configureUI()
		self.view.addSubview(webView)
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
		
		webView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
}

// MARK: Func
extension DetailViewController {}
