//
//  BottomSheetRootView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 3/02/22.
//

import SwiftUI

struct BottomSheetRootView: View {
    @State var show = false
    
    var body: some View {
        ZStack {
            CategoryHome().environmentObject(LandmarkModelData())
            if show {
                Color.blue.opacity(0.3).ignoresSafeArea()
                BottomSheet(show: $show)
                    .transition(.move(edge: .bottom))
                    .zIndex(1) // make sure the bottom sheet always on top
                    
            }
        }
        .onTapGesture {
            withAnimation {
                show.toggle()
            }
        }
    }
}

struct BottomSheetRootView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetRootView()
    }
}
