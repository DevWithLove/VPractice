//
//  CardRootView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 6/02/22.
//

import SwiftUI

struct CardRootView: View {
    var body: some View {
        VStack {
            Card {
                VStack {
                    Text("Hello World")
                    Image(systemName: "face.smiling")
                }
            }
            Card().padding()
        }
    }
}

struct CardRootView_Previews: PreviewProvider {
    static var previews: some View {
        CardRootView()
    }
}
