//
//  AutomationStorage.swift
//  CacheDrop
//
//  Created by Fatin on 17/02/26.
//
import Foundation

final class AutomationStorage {
    
    private let defaults = UserDefaults.standard
    
    private func key(for locationKey: String) -> String {
        "automation.setting.\(locationKey)"
    }
    
    func save(_ setting: AutomationSetting) {
        do {
            let data = try JSONEncoder().encode(setting)
            debugPrint("Saving UD key:", key(for: setting.locationKey))
            debugPrint("Saving UD data:", data)
            defaults.set(data, forKey: key(for: setting.locationKey))
        } catch {
            assertionFailure("Encoding failed")
        }
    }
    
    func load(for location: any ClearableLocation) -> AutomationSetting? {
        let storageKey = key(for: location.persistenceKey)
        
        guard let data = defaults.data(forKey: storageKey) else {
            return nil
        }
        debugPrint("Loading UD: \(storageKey)")
        debugPrint("Loading UD data: \(data)")
        return try? JSONDecoder().decode(AutomationSetting.self, from: data)
    }
    
    func remove(for locationKey: String) {
        defaults.removeObject(forKey: key(for: locationKey))
    }
}
