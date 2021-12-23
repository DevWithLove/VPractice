//
//  RepositoryService.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/12/21.
//

typealias RepositoryServiceResult = (Result<RepositorySearchResultDto, ApiError>) -> Void

protocol RepositoryServiceProtocol {
    func fetch(completion: @escaping RepositoryServiceResult)
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
}
