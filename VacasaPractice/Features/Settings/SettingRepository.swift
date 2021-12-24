//
//  SettingRepository.swift
//  VacasaPractice
//
//  Created by Tony Mu on 24/12/21.
//

import Foundation

protocol SettingRepositoryProtocol {
    /// Return a list of app settings
    func get() -> [SettingOption]
}

class SettingRepository: SettingRepositoryProtocol {
    func get() -> [SettingOption] {
        let appVersionSetting = ReadOnlySettingOption(settingType: .support, title: "App Version", value: "1.0")
        let notificationSetting = SwitchSettingOption(settingType: .other, title: "Notification", value: true)
        let emailSetting = SwitchSettingOption(settingType: .other, title: "Email", value: false)
        return [appVersionSetting, notificationSetting, emailSetting]
    }
}
