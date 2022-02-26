//
//  Expense.swift
//  VacasaPractice
//
//  Created by Tony Mu on 27/02/22.
//

import Foundation

struct Expense: Identifiable {
    var id = UUID().uuidString
    var amountSpent: String
    var product: String
    var productIcon: String
    var spendType: String
}

var expenses: [Expense] = [
    Expense(amountSpent: "$1.21", product: "Amazon", productIcon: "apple", spendType: "Groceries"),
    Expense(amountSpent: "$1.21", product: "Amazon", productIcon: "apple", spendType: "Groceries"),
    Expense(amountSpent: "$1.21", product: "Amazon", productIcon: "apple", spendType: "Groceries"),
    Expense(amountSpent: "$1.21", product: "Amazon", productIcon: "apple", spendType: "Groceries"),
    Expense(amountSpent: "$1.21", product: "Amazon", productIcon: "apple", spendType: "Groceries"),
    Expense(amountSpent: "$1.21", product: "Amazon", productIcon: "apple", spendType: "Groceries"),
    Expense(amountSpent: "$1.21", product: "Amazon", productIcon: "apple", spendType: "Groceries"),
    Expense(amountSpent: "$1.21", product: "Amazon", productIcon: "apple", spendType: "Groceries"),
    Expense(amountSpent: "$1.21", product: "Amazon", productIcon: "apple", spendType: "Groceries")
]
