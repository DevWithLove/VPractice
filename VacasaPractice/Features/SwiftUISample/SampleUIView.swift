//
//  SampleUI.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/01/22.
//

import SwiftUI

enum SampleUIItems: String, CaseIterable {
    case expandableButton = "Expandable Button"
    case hikeView = "Hike view"
    case landmark = "Landmarks"
    case landmarkCategory = "Landmarks categories"
    
    @ViewBuilder
    func getDestiationView() -> some View {
        switch(self) {
        case .expandableButton:
            ExpandableButtonRootView()
        case .hikeView:
            HikeView(hike: Hike.mockHikes[0])
        case .landmark:
            LandmarkContentView()
        case .landmarkCategory:
            CategoryHome().environmentObject(ModelData())
        }
    }
}

struct SampleUIView: View {
    private let items = SampleUIItems.allCases
    
    var body: some View {
        NavigationView {
            List(items, id: \.self) { item in
                NavigationLink(item.rawValue) {
                    item.getDestiationView()
                }
            }
            .navigationBarTitle("Swift UI Sample")
        }
    }
}

struct SampleUI_Previews: PreviewProvider {
    static var previews: some View {
        SampleUIView().previewAsScreen()
    }
}
