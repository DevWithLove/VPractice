//
//  ScreenPreview.swift
//  VacasaPractice
//
//  Created by Tony Mu on 20/01/22.
//

import SwiftUI

struct ScreenPreview<Screen: View>: View {
    var screen: Screen
    var body: some View {
        ForEach(deviceNames, id: \.self) { device in
            ForEach(ColorScheme.allCases, id: \.self) { scheme in
                NavigationView {
                    self.screen
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                }
                .previewDevice(PreviewDevice(rawValue: device))
                .colorScheme(scheme)
                .previewDisplayName("\(scheme): \(device)")
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }

    private var deviceNames: [String] {
        [
            "iPhone 12 Pro",
//            "iPhone 11",
//            "iPhone 11 Pro Max",
//            "iPad (7th generation)",
//            "iPad Pro (12.9-inch) (4th generation)"
        ]
    }
}

extension View {
    func previewAsScreen() -> some View {
        ScreenPreview(screen: self)
    }
}
