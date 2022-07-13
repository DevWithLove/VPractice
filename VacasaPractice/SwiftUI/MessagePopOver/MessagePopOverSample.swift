//
//  MessaePopOver.swift
//  VacasaPractice
//
//  Created by Tony Mu on 12/07/22.
//

import SwiftUI

struct MessagePopOverSample: View {
    @State private var selectedMessageId: String? = "button1"
    @State private var popOverHeight: CGFloat = .zero

    var body: some View {
        ScrollView(.vertical) {
            VStack (alignment: .leading, spacing: 20) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.pink)
                    .frame(width: 300, height: 200)

                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.yellow)
                    .frame(width: 300, height: 200)

                Button {
                    selectedMessageId = "button1"
                } label: {
                    HStack {
                        Text("Click on to see get detail 1")
                        Image(systemName: "info.circle")
                    }
                }.anchorPreference(key: PopOverTextPreferenceKey.self
                                   , value: .bounds) { value in
                    return ["button1": value]
                }

                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.green)
                    .frame(width: 300, height: 200)

                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue)
                    .frame(width: 300, height: 200)

                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.purple)
                    .frame(width: 300, height: 200)

                Button {
                    selectedMessageId = "button2"
                } label: {
                    HStack {
                        Text("Click on to see get detail 2")
                        Image(systemName: "info.circle")
                    }
                }.anchorPreference(key: PopOverTextPreferenceKey.self
                                   , value: .bounds) { value in
                    return ["button2": value]
                }

                Button {
                    selectedMessageId = "button3"
                } label: {
                    HStack {
                        Text("Click on to see get detail 3")
                        Image(systemName: "info.circle")
                    }
                }.anchorPreference(key: PopOverTextPreferenceKey.self
                                   , value: .bounds) { value in
                    return ["button3": value]
                }
            }
            .padding(.bottom, popOverHeight)
            .frame(maxWidth: .infinity)
        }
        .overlayPreferenceValue(PopOverTextPreferenceKey.self) { value in
            if let messageId = selectedMessageId,
               let anchor = value[messageId] {
                GeometryReader{ proxy in
                    let rect = proxy[anchor]
                    VCMessagePopOver(selectedMessageId: $selectedMessageId, content: {
                        VStack (spacing: 20) {
                            Text("sdfsd dsfsdfdsf d dsfsf dsfsd fds fsd fsd fds fdsf ds fds fdd dsf ds fds button \(messageId)")

                            Text("sdfsd dsfsdfdsf d dsfsf dsfsd fds fsd fsd fds fdsf ds fds fdd dsf ds fds button \(messageId)")
                        }
                        .frame(maxWidth: .infinity)
                        .coordinateSpace(name: "PopOverContent")
                    })
                    .measureSize(perform: { size in
                        popOverHeight = size.height
                    })
                    .offset(y: rect.maxY + 10)
                }
            }
        }
        .onTapGesture {
            selectedMessageId = nil
            popOverHeight = .zero
        }
    }
}

struct VCMessagePopOver<Content: View>: View {
    @Binding var selectedMessageId: String?
    let content: ()-> Content

    var body: some View {
        ZStack (alignment: .leading) {
            content().padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray)
        )
        .padding(.horizontal, 20)
        .onTapGesture {
            selectedMessageId = nil
        }
    }
}

struct MessagePopOverSample_Previews: PreviewProvider {
    static var previews: some View {
        MessagePopOverSample()
    }
}

struct PopOverTextPreferenceKey: PreferenceKey {
    // Sorting all the bounds value with message ID as key
    static var defaultValue: [String: Anchor<CGRect>] = [:]

    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()){$1}
    }
}


struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero

  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

struct MeasureSizeModifier: ViewModifier {
  func body(content: Content) -> some View {
    content.background(GeometryReader { geometry in
      Color.clear.preference(key: SizePreferenceKey.self,
                             value: geometry.size)
    })
  }
}

extension View {
  func measureSize(perform action: @escaping (CGSize) -> Void) -> some View {
    self.modifier(MeasureSizeModifier())
      .onPreferenceChange(SizePreferenceKey.self, perform: action)
  }
}
