//
//  RepositoryListRow.swift
//  VacasaPractice
//
//  Created by Tony Mu on 17/01/22.
//

import SwiftUI

struct RepositoryListRow: View {
    var repository: Repository
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(repository.name)
                    .font(.title)
                Text(repository.description)
                    .font(.body)
            }
            Spacer()
        }
    }
}

struct RepositoryListRow_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListRow(repository:Repository(name: "Repository 1", description: "description ....."))
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
