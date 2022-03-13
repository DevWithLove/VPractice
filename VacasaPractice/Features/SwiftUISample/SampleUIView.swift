//
//  SampleUI.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/01/22.
//

import SwiftUI

enum SampleUIItems: String, CaseIterable {
    case editMode = "Edit Mode"
    case expandableButton = "Expandable Button"
    case hikeView = "Hike view"
    case landmark = "Landmarks"
    case landmarkCategory = "Landmarks categories"
    case bottomSheet = "Bottom sheet"
    case navigation = "Navigation"
    case cardView = "Card view"
    case appState = "App State"
    case fastingTimer = "Fasting Timer"
    case weatherDemo = "Weather Demo"
    case scrollingEffect = "Scrolling Effect"
    case walletHomeView = "Wallet Animation"
    case minimalAnimationHomeView = "Minimal Animation"
    case calendar = "Calendar"
    case dragDropView = "Drag drop view"
    
    @ViewBuilder
    func getDestiationView() -> some View {
        switch(self) {
        case .editMode:
            EditModeHomeView()
                .navigationBarTitle(Text("Edit Mode"), displayMode: .inline)
        case .expandableButton:
            ExpandableButtonRootView()
        case .hikeView:
            HikeView(hike: Hike.mockHikes[0])
        case .landmark:
            LandmarkContentView()
        case .landmarkCategory:
            CategoryHome().environmentObject(LandmarkModelData())
        case .bottomSheet:
            BottomSheetRootView()
        case .navigation:
            NavRootView()
        case .cardView:
            CardRootView()
        case .appState:
            AppStateView()
        case .fastingTimer:
            FastingTimerRootView()
                .navigationBarTitle(Text("Fasting timer"), displayMode: .inline)
                //.navigationBarHidden(true)
        case .weatherDemo:
            WeatherDemoContentView()
                .navigationBarTitle(Text("Weather demo"), displayMode: .inline)
        case .scrollingEffect:
            ScrollingEffectRootView()
                .navigationBarTitle(Text("Scrolling Effect"), displayMode: .inline)
        case .walletHomeView:
            WalletHomeView()
                .navigationBarTitle(Text("Wallet Animation"), displayMode: .inline)
        case .minimalAnimationHomeView:
            MinimalAnimationHomeView()
                .navigationBarTitle(Text("Minimalet Animation"), displayMode: .inline)
        case .calendar:
            CustomDatePickerHomeView()
                .navigationBarTitle(Text("Calendar"), displayMode: .inline)
        case .dragDropView:
            DropDragHomeView()
                .navigationBarTitle(Text("Drag drop"), displayMode: .inline)
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
