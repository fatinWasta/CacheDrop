    //
    //  AutomationViewModel.swift
    //  CacheDrop
    //
    //  Created by Fatin on 17/02/26.
    //

import SwiftUI
import Foundation
import Combine

enum CleaningFrequency: String, CaseIterable, Codable {
    case day
    case week
    case month
    
    var timeInterval: TimeInterval {
        switch self {
        case .day: return 60 * 60 * 24
        case .week: return 60 * 60 * 24 * 7
        case .month: return 60 * 60 * 24 * 30
        }
    }
}

final class AutomationViewModel: ObservableObject {
    
    @Published var archivesSetting: AutomationSetting
    @Published var derivedDataSetting: AutomationSetting
   
    private var timers: [XcodeStorageLocation: Timer] = [:]
    private let storage = AutomationStorage()
    private let useCase: DefaultAutomationUseCase
    
    init(useCase: DefaultAutomationUseCase) {
        self.useCase = useCase
        
        self.derivedDataSetting = storage.load(location: .derivedData)  ?? AutomationSetting(type: .derivedData,
                                                                                             isEnabled: false,
                                                                                             frequency: .day,
                                                                                             nextRunAt: nil)
        
        self.archivesSetting = storage.load(location: .archives) ?? AutomationSetting(type: .archives,
                                                                                      isEnabled: false,
                                                                                      frequency: .day,
                                                                                      nextRunAt: nil)
        
        restoreIfNeeded()
    }
    
    func toggleDerivedData() {
        handle(setting: derivedDataSetting)
    }
    
    func toggleArchives() {
        handle(setting: archivesSetting)
    }
}

private extension AutomationViewModel {
    
    private func handle(setting: AutomationSetting) {
        
        if !setting.isEnabled {
            cancel(setting.type)
            storage.remove(location: setting.type)
            return
        }
        
        var updated = setting
        updated.nextRunAt = Date.next4PM(frequency: setting.frequency)
        
        storage.save(updated)
        apply(updated)
        
        schedule(updated)
    }
    
    private func apply(_ setting: AutomationSetting) {
        switch setting.type {
        case .derivedData:
            derivedDataSetting = setting
        case .archives:
            archivesSetting = setting
        case .deviceSupport:
            break
        }
    }
    
    func restoreIfNeeded() {
        let settings: [AutomationSetting] = [
            derivedDataSetting,
            archivesSetting
        ]
        
        for setting in settings {
            guard setting.isEnabled else { continue }
            
            var restored = setting
            
            if restored.nextRunAt == nil {
                restored.nextRunAt = Date.next4PM(frequency: restored.frequency)
                storage.save(restored)
                apply(restored)
            }
            
            schedule(restored)
        }
    }
    
    
    private func runAutomation(for setting: AutomationSetting) {
        
        useCase.execute(setting: setting)
        
        var updated = setting
        updated.nextRunAt = Date.next4PM(frequency: setting.frequency)
        
        storage.save(updated)
        
        apply(updated)
        
        schedule(updated)
    }
    
    func schedule(_ setting: AutomationSetting) {
        
        guard let nextRun = setting.nextRunAt else { return }
        
        cancel(setting.type)
        
        let interval = nextRun.timeIntervalSinceNow
        guard interval > 0 else { return }
        
        let timer = Timer(timeInterval: interval, repeats: false) { [weak self] _ in
            self?.runAutomation(for: setting)
        }
        
        timers[setting.type] = timer
        RunLoop.main.add(timer, forMode: .common)
    }
    
    func cancel(_ location: XcodeStorageLocation) {
        timers[location]?.invalidate()
        timers.removeValue(forKey: location)
    }
    
}
