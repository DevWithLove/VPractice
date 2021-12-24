//
//  RepositoriesListViewModel.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/12/21.
//

import Foundation

protocol RepositoriesListViewModelDelegate: AnyObject {
    func displayError(_ error: ListError)
    func didLoadData()
}

protocol RepositoriesListViewModelPortocol {
    var delegate: RepositoriesListViewModelDelegate? { get set }
    var items: [Repository] { get }
    var title: String { get }
    func loadList()
}

class DisplayListViewModel: RepositoriesListViewModelPortocol {

    private let repositoryWebServcie: RepositoryServiceProtocol
    
    weak var delegate: RepositoriesListViewModelDelegate?
    
    init(repositoryWebServcie: RepositoryServiceProtocol = RepositoryWebService()) {
        self.repositoryWebServcie = repositoryWebServcie
    }
    
    var title: String = "Repositories"
    
    var items: [Repository] = []
    
    func loadList() {
        repositoryWebServcie.fetch { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let resultDto):
                self.items = resultDto.items!.compactMap { $0.toReposiotry() }
                self.delegate?.didLoadData()
            case .failure(_) :
                self.delegate?.displayError(.fetchRepositoriesFailed)
            }
        }
    }
}

extension RepositoryDto {
    func toReposiotry() -> Repository? {
        guard let name = name,
              let description = description else { return nil }
        return Repository(name: name, description: description)
    }
}
