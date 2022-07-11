//
//  BoundsPreference.swift
//  VacasaPractice
//
//  Created by Tony Mu on 10/07/22.
//

import SwiftUI

struct BoundsPreference: PreferenceKey {
    // Sorting all the bounds value with message ID as key
    static var defaultValue: [String: Anchor<CGRect>] = [:]

    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()){$1}
    }
}
