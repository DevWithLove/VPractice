//
//  Level3.swift
//  VacasaPractice
//
//  Created by Tony Mu on 5/02/22.
//

import SwiftUI

struct Level3: View {
    @State private var isActive = false
    @State private var isPresented = false

    var body: some View {
        VStack {
            NavigationLink(isActive: $isActive) {
                DestinationView()
            } label: {
                EmptyView()
            }

            Text("")
                .sheet(isPresented: $isPresented) {
                    DestinationView()
                }
        }
        .navigationTitle("Level 3")
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                //isActive.toggle()
                isPresented.toggle()
            }
        }
    }
}

struct Level3_Previews: PreviewProvider {
    static var previews: some View {
        Level3()
    }
}
