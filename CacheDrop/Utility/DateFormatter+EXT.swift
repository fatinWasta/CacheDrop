//
//  DateFormatter+EXT.swift
//  CacheDrop
//
//  Created by Fatin on 19/02/26.
//

import Foundation

extension DateFormatter {
    
    static let automationFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = .current
        return formatter
    }()
}
