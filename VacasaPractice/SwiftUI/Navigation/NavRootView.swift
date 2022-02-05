//
//  NavRootView.swift.swift
//  VacasaPractice
//
//  Created by Tony Mu on 5/02/22.
//

import SwiftUI

struct NavRootView: View {
    var body: some View {
        List {
            NavigationLink("Level 2") {
                Level2()
            }
            NavigationLink("Level 3") {
                Level3()
            }
        }
    }
}

struct NavRootView_swift_Previews: PreviewProvider {
    static var previews: some View {
        NavRootView()
    }
}
