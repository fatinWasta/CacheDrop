//
//  AutomationSettings.swift
//  CacheDrop
//
//  Created by Fatin on 17/02/26.
//

import Foundation

protocol AutomationUseCase {
    func execute(setting: AutomationSetting) throws
}

final class DefaultAutomationUseCase: AutomationUseCase {
    
    private let repository: IDEStorageRepository
    
    init(repository: IDEStorageRepository) {
        self.repository = repository
    }
    
    func execute(setting: AutomationSetting) {
        guard setting.isEnabled else { return }
        
        Task {
            try? await repository.delete(location: setting.type)
        }
    }
}
