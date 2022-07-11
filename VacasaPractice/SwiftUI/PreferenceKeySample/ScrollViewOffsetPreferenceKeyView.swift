//
//  ScrollViewOffsetPreferenceKeyView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 11/07/22.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        defaultValue = nextValue()
    }
}

extension View {
    func onScrollViewOffsetChanged(action: @escaping (_ offset: CGFloat)->Void) -> some View {
        self.background (
            // Add feak background to get the title position
            GeometryReader { geo in
                Text("").preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).midY) // mid y is the top of the title
            }
        )
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            action(value)
        }
    }
}

struct ScrollViewOffsetPreferenceKeyView: View {
    let title: String = "New title here!"
    @State private var scrollViewOffset: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 63.0)
                    .onScrollViewOffsetChanged { value in
                        withAnimation {
                            self.scrollViewOffset = value
                        }
                    }
                contentLayer
            }
            .padding()
        }
        .overlay(Text("\(scrollViewOffset)"))
        .overlay(navBarLayer.opacity(scrollViewOffset < 40 ? 1.0 : 0.0) , alignment: .top)
    }
}

struct ScrollViewOffsetPreferenceKeyView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferenceKeyView()
    }
}

extension ScrollViewOffsetPreferenceKeyView {
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var contentLayer: some View {
        ForEach(0..<100){ _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }

    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.blue)
    }
}
