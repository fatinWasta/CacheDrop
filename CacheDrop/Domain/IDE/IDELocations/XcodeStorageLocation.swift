//
//  XcodeStorageLocation.swift
//  CacheDrop
//
//  Created by Fatin on 16/02/26.
//

import Foundation


public enum XcodeStorageLocation: ClearableLocation, CaseIterable, Codable {
    case derivedData
    case archives
    case deviceSupport
    
    var displayName: String {
           switch self {
           case .derivedData:
               return "Derived Data"
           case .archives:
               return "Archives"
           case .deviceSupport:
               return "Device Support"
           }
       }
    
    var url: URL {
        let library = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
        
        switch self {
        case .derivedData:
            return library
                .appendingPathComponent("Developer/Xcode/DerivedData", isDirectory: true)
            
        case .archives:
            return library
                .appendingPathComponent("Developer/Xcode/Archives", isDirectory: true)
            
        case .deviceSupport:
            return library
                .appendingPathComponent("Developer/Xcode/iOS DeviceSupport", isDirectory: true)
        }
    }
}
extension XcodeStorageLocation {
    var persistenceKey: String {
        switch self {
        case .derivedData: return "derivedData"
        case .archives: return "archives"
        case .deviceSupport: return "deviceSupport"
        }
    }
}
