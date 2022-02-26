//
//  Card.swift
//  VacasaPractice
//
//  Created by Tony Mu on 26/02/22.
//

import Foundation

struct CreditCard: Identifiable {
    var id = UUID().uuidString
    var name: String
    var cardNumber: String
    var cardImage: String
}

var cards: [CreditCard] =
    [CreditCard(name: "Justine", cardNumber: "2323 4434 9989 0934", cardImage: "Card1"),
     CreditCard(name: "Jenna", cardNumber: "7532 3333 5320 3332", cardImage: "Card2"),
     CreditCard(name: "Jessica", cardNumber: "3200 2222 9989 3223", cardImage: "Card1")
]

//extension CreditCard {
//    static var mock: [CreditCard] {
//       [CreditCard(name: "Justine", cardNumber: "2323 4434 9989 0934", cardImage: "Card1"),
//        CreditCard(name: "Jenna", cardNumber: "7532 3333 5320 3332", cardImage: "Card2"),
//        CreditCard(name: "Jessica", cardNumber: "3200 2222 9989 3223", cardImage: "Card1")]
//    }
//}
