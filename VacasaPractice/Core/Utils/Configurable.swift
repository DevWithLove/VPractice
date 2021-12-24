//
//  Configurable.swift
//  VacasaPractice
//
//  Created by Tony Mu on 24/12/21.
//

/// The interface for configure view with a given model
protocol Configurable {
    associatedtype Model
    func configureWithModel(_:Model)
}
