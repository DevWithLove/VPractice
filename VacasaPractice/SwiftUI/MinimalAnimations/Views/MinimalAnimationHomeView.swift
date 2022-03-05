//
//  MinimalAnimationHomeView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 2/03/22.
//

import SwiftUI

struct MinimalAnimationHomeView: View {
    // MARK: Animation Properties
    @State var animatedStates: [Bool] = Array(repeating: false, count: 3)
    // Hero Effect
    @Namespace var animation

    var body: some View {
        ZStack {

            if !animatedStates[1] {
                RoundedRectangle(cornerRadius: animatedStates[0] ? 30 : 0, style: .continuous)
                    .fill(Color("Purple"))
                    .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                    .ignoresSafeArea()
            }

            if animatedStates[0] {
                // MARK: home view
                VStack(spacing: 0) {

                    // Custom Calendar
                    
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color("Purple"))
                        .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                        .frame(height: 290)
                }
                .padding([.horizontal, .top])
            }
        }
        .onAppear(perform: startAnimations)
    }

    // Animating View
    func startAnimations() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                animatedStates[0] = true
            }
            // Removing view after the view is animatd
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                animatedStates[1] = true
            }
        }
    }
}

struct MinimalAnimationHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MinimalAnimationHomeView()
    }
}
