//
//  DebugLog.swift
//  GitIssuesExample
//
//  Created by 엄기철 on 2022/03/16.
//

import Foundation

public func DebugLog(_ message: Any, file: String = #file, function: String = #function, line: UInt = #line) {
#if DEBUG
	let fileName = file.split(separator: "/").last ?? ""
	let funcName = function.split(separator: "(").first ?? ""
	print("😱 [\(fileName)] \(funcName) (\(line)): \(message)")
#endif
}

public func ErrorLog(_ message: Any, file: String = #file, function: String = #function, line: UInt = #line) {
#if DEBUG
	let fileName = file.split(separator: "/").last ?? ""
	let funcName = function.split(separator: "(").first ?? ""
	print("🥵 [\(fileName)] \(funcName) (\(line)): \(message)")
#endif
}
