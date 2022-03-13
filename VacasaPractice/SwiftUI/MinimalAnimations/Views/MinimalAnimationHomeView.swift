//
//  MinimalAnimationHomeView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 2/03/22.
//

import SwiftUI

struct MinimalAnimationHomeView: View {
    // MARK: Animation Properties
    @State var animatedStates: [Bool] = Array(repeating: false, count: 3)
    // Hero Effect
    @Namespace var animation
    @State var currentDate = Date()

    var body: some View {
        ZStack {

            if !animatedStates[1] {
                RoundedRectangle(cornerRadius: animatedStates[0] ? 30 : 0, style: .continuous)
                    .fill(Color("Purple"))
                    .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                    .ignoresSafeArea()

//                // Splash logo
//                Image(systemName: "plus")
//                    .scaleEffect(animatedStates[0] ? 0.25 : 1)
//                    .matchedGeometryEffect(id: "SPKASHLOGO", in: animation)
            }

            if animatedStates[0] {
                // MARK: home view
                VStack(spacing: 0) {
                    // MARK: Nav bar
                    Button{

                    } label: {
                        Image(systemName: "rectangle.leadinghalf.inset.filled")
                            .font(.title3)
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .overlay(content: {
                        Text("All debts")
                            .font(.title3)
                            .fontWeight(.semibold)
                    })
                    .padding(.bottom, 30)

                    // Custom Calendar
                    CustomDatePicker2(currentDate: $currentDate)
                        .background{
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(Color("Purple"))
                                .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                        }

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(users){ user in
                                UserCardView(user: user, index: getIndex(user: user))
                            }
                        }
                        .padding(.vertical)
                        .padding(.top, 30)
                    }

                }
                .padding([.horizontal, .top])
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .onAppear(perform: startAnimations)
    }

    func getIndex(user: User) -> Int{
        return users.firstIndex { currentUser in
            return user.id == currentUser.id
        } ?? 0
    }

    // Animating View
    func startAnimations() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                animatedStates[0] = true
            }
            // Removing view after the view is animatd
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                animatedStates[1] = true
            }
        }
    }
}

struct MinimalAnimationHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MinimalAnimationHomeView()
    }
}
