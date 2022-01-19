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
        do {
            repositories = try await repositoryService.fetch().items?.compactMap{
                $0.toReposiotry()
            } ?? []
            isLoading.toggle()
        }
        catch let error as ApiError {
            showAlert = true
            isLoading.toggle()
            errorMessage = error.errorDescription
        }
        catch {
            showAlert = true
            isLoading.toggle()
            errorMessage = "Unknown error"
        }
    }
}
