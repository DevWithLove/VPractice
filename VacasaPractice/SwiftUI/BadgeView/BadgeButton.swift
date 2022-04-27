//
//  BadgeButton.swift
//  VacasaPractice
//
//  Created by Tony Mu on 27/04/22.
//

import SwiftUI

struct BadgeButton: View {
    var body: some View {
        ZStack {
            Button {

            } label: {
                Image(systemName: "bell.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .foregroundColor(Color.black)
            .padding()
            .background(Color.gray)
            .clipShape(Circle())

            Text("1")
                .padding(10)
                .background(Color.red)
                .clipShape(Circle())
                .foregroundColor(Color.white)
                .offset(x:20, y: -25)
        }

    }
}

struct BadgeButton_Previews: PreviewProvider {
    static var previews: some View {
        BadgeButton()
    }
}
