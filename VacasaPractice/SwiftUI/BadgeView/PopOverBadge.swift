//
//  PopOverBadge.swift
//  VacasaPractice
//
//  Created by Tony Mu on 27/04/22.
//

import SwiftUI

struct PopOverBadgeHomeView: View {
    var body: some View {
        PopOverBadge()
    }
}


struct PopOverBadge: View {

    @State var count = 0
    @State var show = false

    var body: some View {
        GeometryReader {_ in
            VStack {
                if self.show && self.count != 0 {
                    HStack(spacing: 12) {
                        Image(systemName: "suit.heart.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.red)
                        Text("\(self.count) Likes")
                    }
                    .padding([.horizontal, .top], 15)
                    .padding(.bottom, 30)
                    .background(.white)
                    .clipShape(ArrowShape())
                }

                Button {

                } label: {
                    Image(systemName: !self.show ? "suit.heart" : "suit.heart.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.red)
                        .padding()
                        .background(.white)
                        .clipShape(Circle())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)
                        .onTapGesture {

            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 1, blendDuration: 1)) {
                self.count += 1
                self.show.toggle()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 1, blendDuration: 1)) {
                    self.show.toggle()
                }
            }


        })
    }
}

struct PopOverBadge_Previews: PreviewProvider {
    static var previews: some View {
        PopOverBadgeHomeView()
    }
}

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height - 10))

            path.addLine(to: CGPoint(x: (rect.width / 2) - 10, y: rect.height - 10))
            path.addLine(to: CGPoint(x: (rect.width / 2) , y: rect.height))
            path.addLine(to: CGPoint(x: (rect.width / 2) + 10, y: rect.height - 10))

            path.addLine(to: CGPoint(x: 0, y: rect.height - 10))
        }
    }
}
