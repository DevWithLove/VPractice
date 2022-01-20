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
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?

    private let repositoryService: RepositoryServiceProtocol
    
    init(repositoryService: RepositoryServiceProtocol) {
        self.repositoryService = repositoryService
    }
    
    @MainActor
    func loadData() async {
        isLoading.toggle()
        
        defer {
            isLoading.toggle()
        }
        
        do {
            repositories = try await repositoryService.fetch().items?.compactMap{
                $0.toReposiotry()
            } ?? []
        }
        catch let error as ApiError {
            showAlert = true
            errorMessage = error.errorDescription
        }
        catch {
            showAlert = true
            errorMessage = "Unknown error"
        }
    }
}
