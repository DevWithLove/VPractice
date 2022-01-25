//
//  ListViewModel.swift
//  Landmarks
//
//  Created by Tony Mu on 17/01/22.
//

import Foundation
import Combine

final class ListViewModel: ObservableObject {
    @Published var landmarks:[Landmark] = Landmark.mockData
}

