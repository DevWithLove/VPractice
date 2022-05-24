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
        BadgeContentView()
.previewInterfaceOrientation(.portrait)
    }
}


// IOS 14 add badge to tabbar

struct BadgeContentView: View {
  @State private var badgeNumber: Int = 10
  private var badgePosition: Int = 2
  private var tabsCount: CGFloat = 2
  @State private var selectedTab = 0
  @State private var name = ""


  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .bottomLeading) {
        // TabView
        TabView(selection: $selectedTab) {
            TextField("Enter your name", text: $name)
                .padding()
            .tabItem {
                Label("Menu", systemImage: "list.dash")
            }.tag(0)

            Text("Second View")
              .tabItem {
                Label("Order", systemImage: "square.and.pencil")
              }.tag(1)
        }
        // Badge View
            ZStack {
              Circle()
                .foregroundColor(.red)

              Text("\(self.badgeNumber)")
                .foregroundColor(.white)
                .font(Font.system(size: 12))
            }
            .frame(width: 20, height: 20)
            .offset(x: ( ( 2 * CGFloat(self.badgePosition)) - 1 ) * ( geometry.size.width / ( 2 * self.tabsCount ) ), y: -30)
            .opacity(self.badgeNumber == 0 ? 0 : 1)
        }
    }.ignoresSafeArea(.keyboard) //otherwise badge view will float
  }
}
