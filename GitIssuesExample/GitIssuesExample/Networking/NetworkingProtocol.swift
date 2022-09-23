	//
	//  NetworkingProtocol.swift
	//  GitIssuesExample
	//
	//  Created by 엄기철 on 2022/03/16.
	//

import Then
import RxSwift
import RxCocoa

enum ApiError: Error {
	case noResponse
	case invalidData
	case unexpected
}

extension ApiError: CustomStringConvertible {
	var description: String {
		switch self {
			case .noResponse:
				return "서버에 응답이 없습니다 잠시후 다시 이용해 주세요."
			case .invalidData:
				return "잘못된 데이터가 입력되었습니다."
			case .unexpected:
				return "현재 일시적인 문제가 생겨 빠르게 개선중입니다.\n이용에 불편을 드려 죄송합니다.\n잠시 후 다시 접속해주세요."
		}
	}
}

protocol NetworkingProtocol {
	func request<T: Codable>(_ targetType: ApiTargetType) -> Single<T>
}

struct Networking: NetworkingProtocol {
	func request<T>(_ targetType: ApiTargetType) -> Single<T> where T: Codable, T: Decodable {
		guard let request = targetType.createCompmnents() else { return Single.error(ApiError.noResponse) }

		return Single.create { single -> Disposable in

			let task = URLSession.shared.dataTask(with: request) { data, response, error in

				guard let status = response as? HTTPURLResponse else {
					single(.failure(ApiError.unexpected))
					return
				}

				guard 200..<300 ~= status.statusCode else { single(.failure(ApiError.unexpected))
					return
				}

				guard let data = data else { single(.failure(ApiError.unexpected))
					return
				}

				guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
					single(.failure(ApiError.invalidData))
					return
				}
				single(.success(decodedData))
			}

			task.resume()

			return Disposables.create {
				task.cancel()
			}
		}
	}
}

