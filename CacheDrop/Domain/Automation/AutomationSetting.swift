//
//  AutomationSetting.swift
//  CacheDrop
//
//  Created by Fatin on 17/02/26.
//
import Foundation

struct AutomationSetting: Codable {
    let locationKey: String
    var isEnabled: Bool
    var frequency: CleaningFrequency
    var nextRunAt: Date?
}

extension AutomationSetting {
    
    var formattedNextRun: String {
        guard isEnabled, let date = nextRunAt else {
            return "Not scheduled"
        }
        
        return "on \(DateFormatter.automationFormatter.string(from: date))"
    }
}



enum LocationRegistry {
    
    static func resolve(key: String) -> (any ClearableLocation)? {
        XcodeStorageLocation.allCases.first { $0.persistenceKey == key }
        ?? AndroidStudioStorageLocation.allCases.first { $0.persistenceKey == key }
    }
}
