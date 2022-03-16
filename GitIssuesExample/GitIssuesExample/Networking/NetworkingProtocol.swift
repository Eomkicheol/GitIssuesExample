	//
	//  NetworkingProtocol.swift
	//  GitIssuesExample
	//
	//  Created by 엄기철 on 2022/03/16.
	//

import SystemConfiguration

import Then
import RxSwift
import RxCocoa
import Moya
import ObjectMapper

var defaultErrorMessage: String = "잠시 후 다시 접속해주세요."

public protocol NetworkingProtocol {
	func request(_ target: TargetType, file: StaticString, function: StaticString, line: UInt) -> Single<Moya.Response>
}

extension NetworkingProtocol {
	func request(_ target: TargetType, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Single<Moya.Response> {
		return self.request(target, file: file, function: function, line: line)
	}
}

public final class Networking: MoyaProvider<MultiTarget>, NetworkingProtocol {
	
	var disposeBag: DisposeBag = DisposeBag()
	
	public func request(_ target: TargetType, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Single<Moya.Response> {
		let requestString = "\(target.method.rawValue) \(target.path)"
		
		return self.rx.request(.target(target))
			.filterSuccessfulStatusCodes()
			.do(onSuccess: { value in
				let message = "SUCCESS: \(requestString) (\(value.statusCode))"
				log.debug(message, file: file, function: function, line: line)
			}, onError: { error in
				if let response = (error as? MoyaError)?.response {
					if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
						let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
						log.warning(message, file: file, function: function, line: line)
					} else if let rawString = String(data: response.data, encoding: .utf8) {
						let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
						log.warning(message, file: file, function: function, line: line)
					} else {
						let message = "FAILURE: \(requestString) (\(response.statusCode))"
						log.warning(message, file: file, function: function, line: line)
					}
				} else {
					let message = "FAILURE: \(requestString)\n\(error)"
					log.debug(message, file: file, function: function, line: line)
				}
				
			}, onSubscribed: {
				let message = "REQUEST: \(requestString)"
				log.debug(message)
			}).catchError {
				guard let error = $0 as? MoyaError else { fatalError("") }
				return .error(NSError(domain: error.localizedDescription, code: 0, userInfo: [:]))
			}
	}
}


public let defaultNetwork = Networking()
