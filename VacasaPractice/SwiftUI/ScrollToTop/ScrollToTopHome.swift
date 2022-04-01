//
//  ScrollToTopHome.swift
//  VacasaPractice
//
//  Created by Tony Mu on 1/04/22.
//

import SwiftUI

struct ScrollToTopHome: View {
    @State var scrollViewOffset: CGFloat = 0
    // Getting start offset and eliminating from current offset so that we will get exact offset...
    @State var startOffset: CGFloat = 0
    var body: some View {
        ScrollViewReader { proxyReader in

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 25) {
                    ForEach(1...30, id: \.self) { index in
                        HStack(spacing: 15) {
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 60, height: 60)
                            VStack(alignment: .leading, spacing: 8) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(height: 22)
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(height: 22)
                                    .padding(.trailing, 100)
                            }
                        }
                    }
                }
                .padding()
                // set id  so that it can scroll to that position
                .id("SCROLL_TO_TOP")
                // Getting scrollView Offset...
                    .overlay(
                        // Using geometry reader to get scrolling offset
                        GeometryReader { proxy-> Color in
                            DispatchQueue.main.async {
                                if startOffset == 0 {
                                    self.startOffset = proxy.frame(in: .global).minY
                                }
                                let offset = proxy.frame(in: .global).minY
                                self.scrollViewOffset = offset - startOffset
                                print(self.scrollViewOffset)
                            }
                            return Color.clear
                        }
                            .frame(width: 0, height: 0, alignment: .top)
                    )
            }
            .ignoresSafeArea()
            // if offset goes less than 450 then showing floating action button at bottom
            .overlay(
                Button(action: {
                    withAnimation {
                        proxyReader.scrollTo("SCROLL_TO_TOP", anchor: .top)
                    }
                }, label: {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.09), radius: 5, x: 5, y: 5)
                })
                    .padding(.trailing)
                    .padding(.bottom, 30)
                    .opacity(scrollViewOffset < 0 ? 1 : 0)
                    .animation(.easeInOut)
                 // fixing at bottom left...
                , alignment: .bottomTrailing
        )
        }
    }
}

struct ScrollToTopHome_Previews: PreviewProvider {
    static var previews: some View {
        ScrollToTopHome()
    }
}
