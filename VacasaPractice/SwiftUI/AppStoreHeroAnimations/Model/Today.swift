//
//  Today.swift
//  VacasaPractice
//
//  Created by Tony Mu on 25/04/22.
//

import Foundation

struct Today: Identifiable {
    var id = UUID().uuidString
    var appName: String
    var appDescription: String
    var appLogo: String
    var bannerTitle: String
    var platformTitle: String
    var artwork: String
}

var todayItems: [Today] = [
    Today(appName: "LEGO Brawls",
          appDescription: "Battle with frieds online",
          appLogo: "turtlerock",
          bannerTitle: "Smash your rivals in LEGO Brawls",
          platformTitle: "Apple Arcade",
          artwork: "turtlerock"),
    Today(appName: "Froza Horizon",
          appDescription: "Racing Game",
          appLogo: "stmarylake",
          bannerTitle: "Your are in charge of the Horizon Festival",
          platformTitle: "Apple Arcade",
          artwork: "stmarylake")
]
