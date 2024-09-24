//  Logger.swift
//  Created by Krzysztof Lech on 20/09/2024.

import Foundation

public struct Logger {

	public static func log(info: String) {
		#if !DEBUG
			return
		#endif

		let prefix = "ℹ️"
		print(prefix, info)
	}

	public static func log(okText: String) {
		#if !DEBUG
			return
		#endif

		let prefix = "👍"
		print(prefix, okText)
	}

	public static func log(error: String) {
		#if !DEBUG
			return
		#endif

		let prefix = "‼️"
		print(prefix, error)
	}
}
