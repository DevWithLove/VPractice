//
//  MockData.swift
//  VacasaPractice
//
//  Created by Tony Mu on 19/01/22.
//

import Foundation

extension RepositorySearchResultDto {
    static var mockRepositorySearchResultDto: RepositorySearchResultDto {
        Bundle.main.decode(RepositorySearchResultDto.self, from: "searchRepository.json")
    }
}
