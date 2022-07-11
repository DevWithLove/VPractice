//
//  PopOverView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 11/07/22.
//

import SwiftUI

struct PopOverContentView: View {
    @State private var isHiddenPopOver : Bool = false
    var body: some View {
        ScrollView {
            VStack {
                Text("sdfs\nsdfsd\nsdfdsf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\n")
//                Text("sdfs\nsdfsd\nsdfdsf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\n")
//                Text("sdfs\nsdfsd\nsdfdsf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\n")
//                Text("sdfs\nsdfsd\nsdfdsf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\n")
                Button {
                    isHiddenPopOver.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
                Text("3242342343242342")
                Text("sdfs\nsdfsd\nsdfdsf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\nsdfsdf\n")
            }
            .withPopOver(isHidden: $isHiddenPopOver)
        }
    }
}

struct PopOverModifier: ViewModifier {
    @Binding var isHidden: Bool

    func body(content: Content) -> some View {
        if isHidden {
            content
        } else {
            ZStack(alignment: .bottom) {
                content
                PopOverView()
                    .frame(maxWidth: .infinity)
            }
//            content
//                .overlay(
//                    ZStack {
//                        GeometryReader { proxy in
//
//                                //.offset(y: 30)
//                        }
//                    }
//                )
//                .onTapGesture {
//                    isHidden = true
//                }
        }
    }
}

extension View {
    func withPopOver(isHidden: Binding<Bool>) -> some View {
        modifier(PopOverModifier(isHidden: isHidden))
    }
}


struct PopOverView: View {
    var body: some View {
        Text("sdf ds fsd fdsfdsfds fdsf dsf sdfdsf sdf sd fsd fdsf dsf ds f  sdfds fdsfdsfdsfsfsdfsdf\n sdfn")
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                Capsule()
                    .fill(.gray)
            )
    }
}

struct PopOverContentView_Previews: PreviewProvider {
    static var previews: some View {
        PopOverContentView()
    }
}


