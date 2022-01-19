//
//  RepositorySearchResultDto.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/12/21.
//

struct RepositorySearchResultDto: Decodable {
    let totalCount: Int?
    let isIncompleted: Bool?
    let items: [RepositoryDto]?
    let test: String
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case isIncompleted = "incomplete_results"
        case items
        case test
    }
}
