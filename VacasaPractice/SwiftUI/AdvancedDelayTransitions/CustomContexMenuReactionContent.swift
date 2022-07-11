//
//  CustomContexMenuReactionContent.swift
//  VacasaPractice
//
//  Created by Tony Mu on 10/07/22.
//

import SwiftUI

struct Message: Identifiable {
    var id: String = UUID().uuidString
    var message: String
    var isReply: Bool = false
    var emojiValue: String = ""
    var isEmojiAdded: Bool = false
}

struct CustomContexMenuReactionContent: View {

    @State var chat: [Message] = [
        Message(message: "Lorem ips is simple dummy text of the printing and typings induestory. lsdf sdfdsf dsk jfldsj flds fds."),
        Message(message: "233 32 Lorem ips is simple dummy text of the printing and typings induestory. lsdf sdfdsf dsk jfldsj flds fds.", isReply: true)
    ]

    @State var showHighlight: Bool = false
    @State var hightligtChat: Message?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(chat) { chat in
                        VStack(alignment: chat.isReply ? .leading : .trailing) {
                            if chat.isEmojiAdded {
                                AnimatedEmoji(emoji: chat.emojiValue, color: chat.isReply ? .blue : Color.gray )
                                    .offset(x: chat.isReply ? -15 : 15)
                                    .padding(.bottom, -25)
                                    .zIndex(1)
                                    .opacity(showHighlight ? 0 : 1)
                            }
                            chatView(message: chat)
                                .zIndex(0)
                            // MARK: Using Anchor preference to read view's anctor values(Bounds)
                                .anchorPreference(key: BoundsPreference.self, value: .bounds, transform: { anchor in
                                    return [chat.id: anchor]
                                })
                        }
                        .padding(chat.isReply ? .leading : .trailing, 60)
                        .onLongPressGesture{
                            withAnimation(.easeOut) {
                                showHighlight = true
                                hightligtChat = chat
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Transitions")
        }
        .overlay(content: {
            if showHighlight {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showHighlight = false
                            hightligtChat = nil
                        }
                    }

            }
        })
        // MARK: Highlighting the value based on the bounds value and with overlyaPreference
        .overlayPreferenceValue(BoundsPreference.self) {value in
            // check whic view is tapped
            if let hightligtChat = hightligtChat, let preference = value.first(where: {item in
                item.key == hightligtChat.id
            }) {
                // To retrieve CGRect From Anchor we need geometry proxy
                GeometryReader{ proxy in
                    let rect = proxy[preference.value]
                    // now preseting view as an overlay view
                    // So that it will look like custom context menu
                    chatView(message: hightligtChat, showLike: true)
                        // while disappear it will not animate
                        // Workaround: Add id to view
                        .id(hightligtChat.id)
                        .frame(width: rect.width, height: rect.height)
                        .offset(x: rect.minX, y: rect.minY)
                }
                .transition(.asymmetric(insertion: .identity, removal: .offset(x: 1)))
            }
        }
    }

    @ViewBuilder
    func chatView(message: Message, showLike: Bool = false) -> some View {
        ZStack(alignment: .bottomLeading) {
            Text(message.message)
                .padding(15)
                .background(message.isReply ? Color.gray.opacity(0.2) : Color.blue)
                .foregroundColor(message.isReply ? .black : .white)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            if showLike {
                EmojiView(hideView: $showHighlight, chat: message) { emoji in
                    // Closing highligt
                    withAnimation(.easeInOut) {
                        showHighlight = false
                        hightligtChat = nil
                    }
                    // Finding Index
                    if let index = chat.firstIndex(where: {chat in
                        chat.id == message.id
                    }) {
                        // Updating values
                        withAnimation(.easeInOut.delay(0.3)) {
                            chat[index].isEmojiAdded = true
                            chat[index].emojiValue = emoji
                        }
                    }
                }
                .offset(y: 56)
            }
        }
    }
}

// Animaged emoji view
struct AnimatedEmoji: View {
    var emoji: String
    var color: Color = .blue

    @State var animationValues: [Bool] = Array(repeating: false, count: 6)

    var body: some View {
        ZStack{
            Text(emoji)
                .font(.system(size: 25))
                .padding(6)
                .background {
                    Circle()
                        .fill(color)
                }
                .scaleEffect(animationValues[2] ? 1 : 0)
                .overlay {
                    Circle()
                        .stroke(color, lineWidth: animationValues[1] ? 0 : 100)
                        .clipShape(Circle())
                        .scaleEffect(animationValues[0] ? 1.6 : 0.01)
                }
                // Random circles
                .overlay {
                    ZStack {
                        ForEach(1...20, id: \.self) { index in
                            Circle()
                                .fill(color)
                                .frame(width: .random(in: 3...5), height: .random(in: 3...5))
                                .offset(x: .random(in: -5...5), y: .random(in: -5...5))
                                .offset(x: animationValues[3] ? 45 : 10)
                                // 360 /20 = 18
                                .rotationEffect(.init(degrees: Double(index) * 18))
                                .scaleEffect(animationValues[2] ? 1 : 0.01)
                                .opacity(animationValues[4] ? 0 : 1)

                        }
                    }
                }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.35)) {
                    animationValues[0] = true
                }
                withAnimation(.easeInOut(duration: 0.45).delay(0.06)) {
                    animationValues[1] = true
                }
                withAnimation(.easeInOut(duration: 0.35).delay(0.3)) {
                    animationValues[2] = true
                }
                withAnimation(.easeInOut(duration: 0.35).delay(0.3)) {
                    animationValues[3] = true
                }
                withAnimation(.easeInOut(duration: 0.55).delay(0.55)) {
                    animationValues[4] = true
                }
            }
        }
    }
}

struct EmojiView: View {
    @Binding var hideView: Bool
    var chat: Message
    var onTap: (String) -> ()
    var emojis: [String] = ["😀","❤️","😚"]
    // animation properties
    // Update the count based on your emoji array size
    @State var animatieEmoji: [Bool] = Array(repeating: false, count: 3)
    @State var animateView: Bool = false

    var body: some View {
        HStack(spacing: 12) {
            ForEach(emojis.indices, id: \.self) { index in
                Text(emojis[index])
                    .font(.system(size: 25))
                    .scaleEffect(animatieEmoji[index] ? 1 : 0.01)
                    .onAppear {
                        // Animating emoji with delay based on index
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut.delay(Double(index) * 0.1)) {
                                animatieEmoji[index] = true
                            }
                        }
                    }
                    .onTapGesture {
                        onTap(emojis[index])
                    }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(.white)
                .mask {
                    Capsule()
                        .scaleEffect(animateView ? 1 : 0, anchor: .leading)
                }
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 0.2)) {
                animateView = true
            }
        }
        .onChange(of: hideView) { newValue in
            if !hideView {
                withAnimation(.easeInOut(duration: 0.2).delay(0.15)) {
                    animateView = false
                }
                for index in emojis.indices {
                    withAnimation(.easeInOut) {
                        animatieEmoji[index] = false
                    }
                }
            }
        }
    }
}

struct CustomContexMenuReactionContent_Previews: PreviewProvider {
    static var previews: some View {
        CustomContexMenuReactionContent()
    }
}
