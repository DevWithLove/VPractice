//
//  Card.swift
//  VacasaPractice
//
//  Created by Tony Mu on 6/02/22.
//

import SwiftUI

struct Card<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder contentBuilder:  ()-> Content) {
        self.content = contentBuilder()
    }
    
    init() where Content == Color {
        self.init {
            Color.white
        }
    }
    
    var body: some View {
        content
            .padding(100)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: .gray, radius: 10, x: 5, y: 5)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card().padding()
        Card {
            VStack {
                Text("Hello World")
                Image(systemName: "face.smiling")
            }
        }
    }
}


