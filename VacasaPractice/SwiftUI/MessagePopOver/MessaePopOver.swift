//
//  MessaePopOver.swift
//  VacasaPractice
//
//  Created by Tony Mu on 12/07/22.
//

import SwiftUI

struct MessaePopOver: View {
    @State private var selectedMessageId: String?// = "button3"

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
                    })
                    .offset(y: rect.maxY + 10)
                }
            }
        }
        .onTapGesture {
            selectedMessageId = nil
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

struct MessaePopOver_Previews: PreviewProvider {
    static var previews: some View {
        MessaePopOver()
    }
}

struct PopOverTextPreferenceKey: PreferenceKey {
    // Sorting all the bounds value with message ID as key
    static var defaultValue: [String: Anchor<CGRect>] = [:]

    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()){$1}
    }
}
