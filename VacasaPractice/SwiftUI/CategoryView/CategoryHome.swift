//
//  CategoryHome.swift
//  VacasaPractice
//
//  Created by Tony Mu on 25/01/22.
//

import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        List {
            
            modelData.features[0].image
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
            
            ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                CategoryRow(categoryName: key, items: modelData.categories[key]!)
            }
            .listRowInsets(EdgeInsets())
        }
        .listStyle(.plain)
        .navigationTitle("Featured")
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
            .previewAsScreen()
    }
}
