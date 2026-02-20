    //
    //  ViewTypeEnum.swift
    //  CacheDrop
    //
    //  Created by Fatin on 19/02/26.
    //

import Foundation

enum ViewType {
    case derivedData
    case gradle
    case applicationSupport
    case cacheGoogle
    case logsGoogle
        
    var title: String {
        switch self {
        case .derivedData:
            return "Derived Data"
            
        case .gradle:
            return ".gradle/caches"
            
        case .applicationSupport:
            return "Application Support/Google"
            
        case .cacheGoogle:
            return "Cache/Google"
        
        case .logsGoogle:
            return "Logs/Google"
        }
    }
    
    var toolTip: String {
        switch self {
        case .derivedData:
            return "Derived Data is like a folder where Xcode keeps the LEGO pieces it builds for your app. If it gets messy, you can throw it away and Xcode will build fresh LEGO pieces again."
            
        case .gradle:
            return "A storage box where Android Studio keeps saved building pieces so it can build apps faster. If cleaned, it can download them again."
            
        case .applicationSupport:
            return "Stores Android Studio configuration files, plugins, caches, logs, and IDE metadata."
            
        case .cacheGoogle:
            return "Contains temporary cache files created by Google services (SDK Manager, emulators, Gradle integrations). Safe to clear; files will be regenerated when required."
            
        case .logsGoogle:
            return "Stores diagnostic logs from Android Studio and related Google tools. Safe to delete; useful only for debugging issues."
        }
    }
}
