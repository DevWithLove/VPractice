//
//  SettingsSection.swift
//  VacasaPractice
//
//  Created by Tony Mu on 24/12/21.
//

import Foundation

enum SettingsType: Int, CaseIterable, CustomStringConvertible, Comparable {
    case support
    case other
    
    var description: String {
        switch self {
        case .support: return "Support"
        case .other: return "Other"
        }
    }
    
    static func < (lhs: SettingsType, rhs: SettingsType) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

protocol SettingOption {
    var settingType: SettingsType { get }
    var title: String { get }
}

struct ReadOnlySettingOption: SettingOption {
    let settingType: SettingsType
    let title: String
    let value: String
}

struct SwitchSettingOption: SettingOption {
    let settingType: SettingsType
    let title: String
    let value: Bool
}
