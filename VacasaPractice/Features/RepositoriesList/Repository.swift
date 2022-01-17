//
//  Repository.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/12/21.
//

import Foundation

struct Repository  {
    let name: String
    let description: String
    
    static func getTestData() -> [Repository] {
        return [Repository(name: "Rep 1", description: "Rep description one"),
                Repository(name: "Rep 2", description: "Rep description two")]
    }
}
