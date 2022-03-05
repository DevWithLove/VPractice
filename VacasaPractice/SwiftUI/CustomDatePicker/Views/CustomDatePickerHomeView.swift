//
//  CustomDatePickerHomeView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 4/03/22.
//

import SwiftUI

struct CustomDatePickerHomeView: View {
    @State var currentDate: Date = Date()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                // Custom Date Picker...
                CustomDatePicker(currentDate: $currentDate)
            }
            .padding(.vertical)
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button {

                } label: {
                    Text("Add Task")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.orange, in: Capsule())
                }

                Button {

                } label: {
                    Text("Add Reminder")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.purple, in: Capsule())
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .foregroundColor(.white)
            .background(.ultraThinMaterial)
        }
    }
}

struct CustomDatePickerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDatePickerHomeView()
    }
}
