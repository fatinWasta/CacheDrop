//
//  AutomationSetting.swift
//  CacheDrop
//
//  Created by Fatin on 17/02/26.
//
import Foundation

struct AutomationSetting: Codable {
    let type: XcodeStorageLocation
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

extension DateFormatter {
    
    static let automationFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = .current
        return formatter
    }()
}
