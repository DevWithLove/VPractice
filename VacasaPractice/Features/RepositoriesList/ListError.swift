//
//  ListError.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/12/21.
//

import Foundation

enum ListError: Error {
    case fetchRepositoriesFailed
}

extension ListError {
    var localizedMessage: String {
        switch self {
        case .fetchRepositoriesFailed:
            return "Sorry, we are unable to get the repositories, please try again later."
        }
    }
}
