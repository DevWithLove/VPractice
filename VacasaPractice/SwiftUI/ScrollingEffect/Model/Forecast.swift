//
//  Forecast.swift
//  VacasaPractice
//
//  Created by Tony Mu on 9/02/22.
//

import SwiftUI

struct DayForecast: Identifiable {
    var id = UUID().uuidString
    var day: String
    var farenheit: CGFloat
    var image: String
}

var forecast = [
    DayForecast(day: "Today", farenheit: 94, image: "sun.min"),
    DayForecast(day: "Wed", farenheit: 93, image: "sun.min"),
    DayForecast(day: "Tue", farenheit: 99, image: "sun.min"),
    DayForecast(day: "Thu", farenheit: 93, image: "sun.min"),
    DayForecast(day: "Fri", farenheit: 99, image: "sun.min"),
    DayForecast(day: "Sat", farenheit: 98, image: "cloud.sun"),
    DayForecast(day: "Sun", farenheit: 94, image: "sun.min"),
    DayForecast(day: "Mon", farenheit: 90, image: "sun.max"),
    DayForecast(day: "Tue", farenheit: 94, image: "sun.min"),
    DayForecast(day: "Wed", farenheit: 94, image: "sun.min")
]
