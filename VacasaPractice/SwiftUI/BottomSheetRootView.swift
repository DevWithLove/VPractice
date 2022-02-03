//
//  BottomSheetRootView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 3/02/22.
//

import SwiftUI

struct BottomSheetRootView: View {
    @State private var bottomSheetShown = false
    @State private var isDismissed = false

    var body: some View {
        ZStack {
            CategoryHome().environmentObject(LandmarkModelData())
            GeometryReader { geometry in
                if !isDismissed {
                    BottomSheetView (
                        isOpen: self.$bottomSheetShown,
                        maxHeight: geometry.size.height * 0.9
                    ) {
                        BottomSheetContentView(show: $isDismissed)
                    }
                    .transition(.move(edge: .bottom))
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            isDismissed = false
            bottomSheetShown = false
        }
    }
    
//    @State private var show = false
//    var body: some View {
//        ZStack {
//            CategoryHome().environmentObject(LandmarkModelData())
//            if show {
//                Color.blue.opacity(0.3).ignoresSafeArea()
//                BottomSheet(show: $show)
//                    .transition(.move(edge: .bottom))
//                    .zIndex(1) // make sure the bottom sheet always on top
//
//            }
//        }
//        .onTapGesture {
//            withAnimation {
//                show.toggle()
//            }
//        }
//    }
}

struct BottomSheetRootView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetRootView()
    }
}
