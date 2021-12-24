//
//  SettingsViewModel.swift
//  VacasaPractice
//
//  Created by Tony Mu on 24/12/21.
//

import Foundation

protocol SettingsViewModelDelegate: AnyObject {
    func didLoadData()
}

protocol SettingsViewModelProtocol {
    var delegate: SettingsViewModelDelegate? { get set }
    var groupedOptions: [GroupedSection<SettingsType, SettingOption>] { get }
    var title: String { get }
    var user: UserInfo { get }
    func loadData()
}

class SettingsViewModel: SettingsViewModelProtocol {
    
    private let settingRepository: SettingRepositoryProtocol
    
    weak var delegate: SettingsViewModelDelegate?
    var groupedOptions: [GroupedSection<SettingsType, SettingOption>] = []
    var title: String = "Settings"
    var user: UserInfo = UserInfo(name: "Tony Mu",
                                  email: "tony.mu@gmail.com",
                                  profileImageName: "vacasa")
    
    init(settingRepository: SettingRepositoryProtocol = SettingRepository()) {
        self.settingRepository = settingRepository
    }
    
    func loadData() {
        let options = settingRepository.get()
        groupedOptions = GroupedSection<SettingsType, SettingOption>.group(items: options, by: { $0.settingType }).sorted(by: { $0.sectionItem < $1.sectionItem})
        delegate?.didLoadData()
    }
}

struct GroupedSection<SectionItem: Hashable, RowItem> {
    var sectionItem: SectionItem
    var rows: [RowItem]
    
    static func group(items: [RowItem], by criteria : (RowItem) -> SectionItem) -> [GroupedSection<SectionItem, RowItem>] {
        let groups = Dictionary(grouping: items, by: criteria)
        return groups.map(GroupedSection.init(sectionItem:rows:))
    }
}
