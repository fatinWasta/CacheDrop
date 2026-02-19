//
//  AndroidStudioLocation.swift
//  CacheDrop
//
//  Created by Fatin on 19/02/26.
//

import Foundation

public enum AndroidStudioStorageLocation: ClearableLocation, CaseIterable, Codable {
    
    case gradleCaches
    case cacheGoogle
    case applicationSupport
    case logsGoogle
    
    var displayName: String {
        switch self {
        case .gradleCaches:
            return "Gradle Caches"
        case .cacheGoogle:
            return "IDE Cache"
        case .applicationSupport:
            return "Application Support"
        case .logsGoogle:
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
            
        case .cacheGoogle:
            return library
                .appendingPathComponent("Caches/Google", isDirectory: true)
            
        case .applicationSupport:
            return library
                .appendingPathComponent("Application Support/Google", isDirectory: true)
            
        case .logsGoogle:
            return library
                .appendingPathComponent("Logs/Google", isDirectory: true)
        }
    }
    
    var persistenceKey: String {
        switch self {
        case .gradleCaches: return "as.gradleCaches"
        case .cacheGoogle: return "as.cacheGoogle"
        case .applicationSupport: return "as.applicationSupport"
        case .logsGoogle: return "as.logsGoogle"
        }
    }
    
}


