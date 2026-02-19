//
//  AutomationStorage.swift
//  CacheDrop
//
//  Created by Fatin on 17/02/26.
//
import Foundation

final class AutomationStorage {
    
    private let defaults = UserDefaults.standard
    
    private func key(for location: XcodeStorageLocation) -> String {
        "automation.setting.\(location.persistenceKey)"
    }
    
    func save(_ setting: AutomationSetting) {
        do {
            let data = try JSONEncoder().encode(setting)
            defaults.set(data, forKey: key(for: setting.type))
        } catch {
            assertionFailure("Encoding failed")
        }
    }
    
    func load(location: XcodeStorageLocation) -> AutomationSetting? {
        guard let data = defaults.data(forKey: key(for: location)) else { return nil }
        let automationSetting = try? JSONDecoder().decode(AutomationSetting.self, from: data)

        return automationSetting
        
    }
    
    func remove(location: XcodeStorageLocation) {
        defaults.removeObject(forKey: key(for: location))
    }
}
