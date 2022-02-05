//
//  Level2.swift
//  VacasaPractice
//
//  Created by Tony Mu on 5/02/22.
//

import SwiftUI

struct Level2: View {
    
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            NavigationLink("Push") {
                DestinationView()
            }
            
            Button {
                isPresented.toggle()
            } label: {
                Text("Present")
            }
            .sheet(isPresented: $isPresented) {
                DestinationView()
            }
            
            Button {
                isPresented.toggle()
            } label: {
                Text("Present FullScreen")
            }
            .fullScreenCover(isPresented: $isPresented) {
                DestinationView()
            }

        }
        .navigationTitle("Level 2")
    }
}

struct Level2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Level2()
        }.previewAsScreen()
    }
}
