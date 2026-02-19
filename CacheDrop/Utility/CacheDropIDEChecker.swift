//
//  CacheDropIDEChecker.swift
//  CacheDrop
//
//  Created by Fatin on 19/02/26.
//

import SwiftUI
import Combine

enum CacheDropIDE {
    case xcode
    case androidStudio
    
    var appPath: String {
        switch self {
        case .xcode:
            return "/Applications/Xcode.app"
        case .androidStudio:
            return "/Applications/Android Studio.app"
        }
    }
    
    var ideNotAvailableError: String {
        switch self {
        case .xcode:
            return "Xcode is not installed on your machine."
        case .androidStudio:
            return "Android Studio is not installed on your machine."
        }
    }
}

class CacheDropIDEChecker {
    static func userMacMachine(has ide: CacheDropIDE) -> Bool {
        return FileManager.default.fileExists(atPath: ide.appPath)
    }
}
