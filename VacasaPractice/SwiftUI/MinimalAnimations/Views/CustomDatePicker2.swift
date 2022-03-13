//
//  CustomDatePicker2.swift
//  VacasaPractice
//
//  Created by Tony Mu on 12/03/22.
//

import SwiftUI
import simd

struct CustomDatePicker2: View {
    @Binding var currentDate: Date

    // Month update on arrow button clicks...
    @State var currentMonth: Int = 0

    // MARK: Animated States
    @State var animatedStates: [Bool] = Array(repeating: false, count: 2)

    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 20) {
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }

                Text(extraData()[0] + " " + extraData()[1])
                    .font(.callout)
                    .fontWeight(.semibold)

                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            .opacity(animatedStates[0] ? 1 : 0)

            Rectangle()
                .fill(.white.opacity(0.4))
                .frame(width: animatedStates[0] ? nil : 0, height: 1)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Dates...
            // Lazy Grid ...
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            if animatedStates[0] {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<extractDate().count, id:\.self) { index in
                        let value = extractDate()[index]

                        PickerCardView(value: value, index: index, currentDate: $currentDate, isFinished: $animatedStates[1])
                            .onTapGesture {
                                currentDate = value.date
                            }
                    }
                }
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(extractDate().indices) { index in
                        let value = extractDate()[index]

                        PickerCardView(value: value, index: index, currentDate: $currentDate, isFinished: $animatedStates[1])
                            .onTapGesture {
                                currentDate = value.date
                            }
                    }
                }
                .opacity(0)
            }
        }
        .padding()
        .onChange(of: currentMonth) { newValue in
            // update Month
            currentDate = getCurrentMonth()
        }
        .onAppear {
            // Animating view with some delay
            // Delay for splash animation to sync with the current one
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 0.3)){
                    animatedStates[0] = true
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                animatedStates[1] = true
            }
        }
    }

    // checking dates...
    // extracting Year and Month for displaying..
    func extraData() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }

    func getCurrentMonth()-> Date {
        let calendar = Calendar.current
        // Getting current month date ...
        guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }

    func extractDate()-> [DateValue] {
        let calendar = Calendar.current
        // Getting current month date ...
        let currentMonth = getCurrentMonth()

        var days = currentMonth.getAllDays().compactMap { date -> DateValue  in
            let day = calendar.component(.day, from: date)

            return DateValue(day: day, date: date)
        }
        // ading offsetdays to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())

        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }

        return days
    }
}

// Global method
func isSameDay(date1: Date, date2: Date) -> Bool {
    let calendar = Calendar.current
    return calendar.isDate(date1, inSameDayAs: date2)
}


// Card View
// Since we need a @State variables for each card view
struct PickerCardView: View {
    var value: DateValue
    var index: Int
    @Binding var currentDate: Date
    @Binding var isFinished: Bool

    // Animating view
    @State var showView: Bool = false

    var body: some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .black : .white)
                    .frame(maxWidth: .infinity)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(.white)
                .padding(.vertical, -5)
                .padding(.horizontal, 5)
                .opacity(isSameDay(date1: currentDate, date2: value.date) ? 1 : 0)
        }
        .opacity(showView ? 1 : 0)
        .onAppear {
            // Since every time month changed its animating
            // Stopping it for only first time
           // if isFinished { showView = true }
            withAnimation(.spring().delay(Double(index) * 0.02)) {
                showView = true
            }
        }
    }

}
