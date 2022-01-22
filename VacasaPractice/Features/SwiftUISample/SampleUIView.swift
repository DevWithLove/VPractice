//
//  SampleUI.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/01/22.
//

import SwiftUI

enum SampleUIItems: String, CaseIterable {
    case expandableButton = "Expandable Button"
    
    func getDestiationView() -> some View {
        switch(self) {
        case .expandableButton:
            return ExpandableButtonRootView()
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
