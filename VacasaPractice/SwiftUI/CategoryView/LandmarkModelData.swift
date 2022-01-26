//
//  LandmarkModelData.swift
//  VacasaPractice
//
//  Created by Tony Mu on 25/01/22.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = Landmark.mockData
    
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }
    
    var categories: [String: [Landmark]] {
        Dictionary(grouping: landmarks) { $0.category.rawValue }
    }
}
