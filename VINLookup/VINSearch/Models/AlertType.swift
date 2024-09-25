//  AlertType.swift
//  Created by Krzysztof Lech on 25/09/2024.

import Foundation

enum AlertType {
	case apiProblem, limitReached, none

	var title: String {
		switch self {
		case .apiProblem:
			VINString.APIproblem.title
		case .limitReached:
			VINString.LimitReached.title
		default: ""
		}
	}

	var message: String {
		switch self {
		case .apiProblem:
			VINString.APIproblem.message
		case .limitReached:
			VINString.LimitReached.message
		default: ""
		}
	}

	var buttonTitle: String {
		switch self {
		case .apiProblem:
			VINString.APIproblem.buttonTitle
		case .limitReached:
			VINString.LimitReached.buttonTitle
		default: ""
		}
	}
}
