//
//  RepositoryListView.swift.swift
//  VacasaPractice
//
//  Created by Tony Mu on 17/01/22.
//

import SwiftUI

struct RepositoryListView: View {
    @StateObject var viewModel = RepositoryListViewModel(repositoryService: RepositoryWebService())
    var body: some View {
        NavigationView {
            List(viewModel.repositories, id: \.name) { repository in
                RepositoryListRow(repository: repository)
            }
            .listStyle(.plain)
            .overlay(content: {
                if viewModel.isLoading {
                    ProgressView()
                }
            })
            .navigationTitle("Repositories")
        }
        .task {
            await viewModel.loadData()
        }
        .alert("Application Error", isPresented: $viewModel.showAlert, actions: {
            Button("OK") {}
        }, message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        })
   
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
    }
}
