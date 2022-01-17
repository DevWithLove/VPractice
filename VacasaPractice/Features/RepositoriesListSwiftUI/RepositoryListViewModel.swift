//
//  RepositoryListViewModel.swift
//  VacasaPractice
//
//  Created by Tony Mu on 17/01/22.
//

import Foundation
import Combine
import UIKit

final class RepositoryListViewModel: ObservableObject {
    @Published var repositories = [Repository]()
    
    private let repositoryService: RepositoryServiceProtocol
    
    init(repositoryService: RepositoryServiceProtocol) {
        self.repositoryService = repositoryService
    }
    
    @MainActor
    func loadData() async {
        do {
            repositories = try await repositoryService.fetch().items?.compactMap{
                $0.toReposiotry()
            } ?? []
        }
        catch {
            
        }
    }
}
