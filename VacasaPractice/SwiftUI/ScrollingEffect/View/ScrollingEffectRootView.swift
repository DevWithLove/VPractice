//
//  ScrollingEffectRootView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 9/02/22.
//

import SwiftUI

struct ScrollingEffectRootView: View {
    var body: some View {
       // Since windows is decreptd in ios 15..
       // Getting safe area using Geometry reader
        GeometryReader { proxy in
            let topEdge = proxy.safeAreaInsets.top
            ScrollingEffectContentView(topEdge: topEdge)
                .ignoresSafeArea(.all, edges: .top)
        }

    }
}

struct ScrollingEffectRootView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingEffectRootView()
    }
}
