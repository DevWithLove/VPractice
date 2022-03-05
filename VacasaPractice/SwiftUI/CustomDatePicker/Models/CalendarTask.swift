//
//  Task.swift
//  VacasaPractice
//
//  Created by Tony Mu on 5/03/22.
//

import Foundation

struct CalendarTask: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

struct TaskMetaDate: Identifiable {
    var id = UUID().uuidString
    var task: [CalendarTask]
    var taskDate: Date
}
// sample date for testing
func getSampleData(offset: Int) -> Date {
    let calender = Calendar.current
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

var tasks: [TaskMetaDate] = [
    TaskMetaDate(task: [
        CalendarTask(title: "Talk to iJustine"),
        CalendarTask(title: "iPhone 13 Great design change"),
        CalendarTask(title: "Nothing much workout !!!")
    ], taskDate: getSampleData(offset: 1)),
    TaskMetaDate(task: [
        CalendarTask(title: "Meeting with Tim!")
    ], taskDate: getSampleData(offset: -3)),
    TaskMetaDate(task: [
        CalendarTask(title: "Talk to Jenna Ezarik")
    ], taskDate: getSampleData(offset: -8)),
]
