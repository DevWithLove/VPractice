//
//  GeometryPreferenceKeySampleView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 11/07/22.
//

import SwiftUI

// pass child view size to parents
struct GeometryPreferenceKeySampleView: View {

    @State private var rectSize: CGSize = .zero

    var body: some View {
        VStack {
            Spacer()
            Text("Hello world")
                .frame(width:rectSize.width ,height: rectSize.height)
                .background(Color.blue)
            Spacer()
            HStack {
                Rectangle()
                // get sie of the rectangle
                GeometryReader { proxy in
                    Rectangle()
                        .updateRectangleGeoSize(proxy.size)
//                        .overlay(
//                            Text("\(proxy.size.width)").foregroundColor(.white)
//                        )
                }
                Rectangle()
            }.frame(height:65)
        }
        .onPreferenceChange(RectangleGeometrySizePreferenceKey.self, perform: { value in
            self.rectSize = value
        })
    }
}

struct GeometryPreferenceKeySampleView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKeySampleView()
    }
}

extension View {
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
    }
}

struct RectangleGeometrySizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
