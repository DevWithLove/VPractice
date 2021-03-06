//
//  CategoryHome.swift
//  VacasaPractice
//
//  Created by Tony Mu on 25/01/22.
//

import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: LandmarkModelData
    @State private var showingProfile = false
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
        .listStyle(.inset)
        .navigationTitle("Featured")
        .toolbar {
            Button {
                showingProfile.toggle()
            } label: {
                Label("User Profile", systemImage: "person.crop.circle")
            }
        }
        .sheet(isPresented: $showingProfile) {
            ProfileHost()
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(LandmarkModelData())
            .previewAsScreen()
    }
}
