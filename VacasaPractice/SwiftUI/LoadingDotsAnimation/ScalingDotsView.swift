//
//  ScalingDotsView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 22/07/22.
//

import SwiftUI

struct DotView: View {
    let size: CGFloat
    @State var scale: CGFloat = 0.5
    @State var delay: Double

    init (size: CGFloat = 8, delay: Double = 0) {
        self.size = size
        self.delay = delay
    }

    var body: some View {
        Circle()
            .frame(width: size, height: size)
            .scaleEffect(scale)
            .onAppear{
                withAnimation(Animation.easeInOut(duration: 0.6).repeatForever().delay(delay)) {
                    self.scale = 1
                }
            }
    }
}

struct ScalingDotsView: View {
    var body: some View {
        HStack {
            DotView()
            DotView(delay: 0.2)
            DotView(delay: 0.4)
        }
    }
}

struct ScalingDotsView_Previews: PreviewProvider {
    static var previews: some View {
        ScalingDotsView()
    }
}
