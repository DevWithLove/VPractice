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
            }.navigationTitle("Repositories")
        }
        .task {
           try? await viewModel.loadData()
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
    }
}
