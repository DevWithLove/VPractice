//
//  RepositoryService.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/12/21.
//

import Foundation

typealias RepositoryServiceResult = (Result<RepositorySearchResultDto, ApiError>) -> Void

protocol RepositoryServiceProtocol {
    func fetch(completion: @escaping RepositoryServiceResult)
    func fetch() async throws -> RepositorySearchResultDto
}

class RepositoryWebService: RepositoryServiceProtocol {
    func fetch(completion: @escaping RepositoryServiceResult) {
        do {
            let parameters = GitHubApi.SearchParameters(qualifiers: "org:vacasaoss",
                                                        sort: "stars",
                                                        order: "desc")
            let request = try GitHubApi.searchRespositories(parameters).request()
            request.send(completion: completion)
        } catch {
            completion(.failure(.unknown(error)))
        }
    }
    
    func fetch() async throws -> RepositorySearchResultDto {
        let parameters = GitHubApi.SearchParameters(qualifiers: "org:vacasaoss",
                                                    sort: "stars",
                                                    order: "desc")
        let request = try GitHubApi.searchRespositories(parameters).request()
        do {
            return try await request.send()
        } catch {
            throw ApiError.unknown(error)
        }
        
        // Or, we can use the bridge method
        // return try await fetchDataUsingBridge()
    }
    
    private func fetchDataUsingBridge() async throws -> RepositorySearchResultDto {
        // Bridge between synchronous and asynchronous code using continuation
        let result: RepositorySearchResultDto = try await withCheckedThrowingContinuation({ continuation in
            // Async task execute the `fetch(completion:)` function
            fetch { result in
                switch result {
                case .success(let resultDto):
                    // Resume with fetched albums
                    continuation.resume(returning: resultDto)
                case .failure(let error):
                    // Resume with error
                    continuation.resume(throwing: error)
                }
            }
        })
        
        return result
    }
}
