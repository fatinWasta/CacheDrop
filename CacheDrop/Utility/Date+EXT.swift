//
//  Date+EXT.swift
//  CacheDrop
//
//  Created by Fatin on 17/02/26.
//

import Foundation

extension Date {
    
    static func next4PM(
        from base: Date = Date(),
        frequency: CleaningFrequency,
        calendar: Calendar = .current
    ) -> Date {
        
        var components = calendar.dateComponents([.year, .month, .day], from: base)
        components.hour = 16
        components.minute = 00
        components.second = 0
        
        //Construct today at 16:00
        guard let todayAt4PM = calendar.date(from: components) else {
            fatalError("Failed to construct 4PM date")
        }
        
        //Ensure result is always in the future
        let firstValid: Date
        if base < todayAt4PM {
            firstValid = todayAt4PM
        } else {
            firstValid = calendar.date(byAdding: .day, value: 1, to: todayAt4PM)!
        }
        
        //Apply frequency offset
        switch frequency {
        case .day:
            return firstValid
            
        case .week:
            return calendar.date(byAdding: .weekOfYear, value: 1, to: firstValid)!
            
        case .month:
            return calendar.date(byAdding: .month, value: 1, to: firstValid)!
        }
    }
}
