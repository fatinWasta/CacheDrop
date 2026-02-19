//
//  AndroidStudioLocation.swift
//  CacheDrop
//
//  Created by Fatin on 19/02/26.
//

import Foundation

public enum AndroidStudioLocation: ClearableLocation, CaseIterable, Codable {
    
    case gradleCaches
    case ideCaches
    case applicationSupport
    case logs
    
    var displayName: String {
        switch self {
        case .gradleCaches:
            return "Gradle Caches"
        case .ideCaches:
            return "IDE Cache"
        case .applicationSupport:
            return "Application Support"
        case .logs:
            return "Logs"
        }
    }
    
    var url: URL {
        let home = FileManager.default.homeDirectoryForCurrentUser
        let library = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
        
        switch self {
        case .gradleCaches:
            return home
                .appendingPathComponent(".gradle/caches", isDirectory: true)
            
        case .ideCaches:
            return library
                .appendingPathComponent("Caches/Google", isDirectory: true)
            
        case .applicationSupport:
            return library
                .appendingPathComponent("Application Support/Google", isDirectory: true)
            
        case .logs:
            return library
                .appendingPathComponent("Logs/Google", isDirectory: true)
        }
    }
}

extension AndroidStudioLocation {
    var persistenceKey: String {
        switch self {
        case .gradleCaches: return "gradleCaches"
        case .ideCaches: return "ideCaches"
        case .applicationSupport: return "applicationSupport"
        case .logs: return "logs"
        }
    }
}
