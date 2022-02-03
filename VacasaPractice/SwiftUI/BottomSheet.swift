//
//  BottomSheet.swift
//  VacasaPractice
//
//  Created by Tony Mu on 3/02/22.
//

/**
 refer to https://www.youtube.com/watch?v=wLLDrx_q7Es&t=879s
 refer to https://swiftwithmajid.com/2019/12/11/building-bottom-sheet-in-swiftui/
 */
import SwiftUI

struct BottomSheet: View {
    @State var translation: CGSize = .zero
    @State var offsetY: CGFloat = 0
    @Binding var show: Bool
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                BottomSheetContentView(show: $show)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .offset(y: translation.height + offsetY)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        translation = value.translation
                    }
                    .onEnded() { value in
                        withAnimation (.interactiveSpring(response: 0.5, dampingFraction: 0.7)){
                            
                            let snap = translation.height + offsetY
                            let quarter = proxy.size.height / 4
                            
                            if snap > quarter && snap < quarter * 3{ // top quiter
                                offsetY = quarter * 2 // middle of screen
                            } else if snap > quarter * 3 {
                                 offsetY = quarter * 3 // bottom of screen
                            } else {
                                offsetY = 0
                            }
                            
                            translation = .zero
                        }
                    }
            )
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(show: .constant(true))
            .background(.blue)
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
