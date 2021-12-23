//
//  ApiError.swift.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/12/21.
//

enum ApiError: Error {
    case urlError(String)
    case notFound
    case invalidedResponse
    case unknown(Error)
    case decodingError
}
