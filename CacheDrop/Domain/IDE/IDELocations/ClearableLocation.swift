//
//  ClearableLocation.swift
//  CacheDrop
//
//  Created by Fatin on 19/02/26.
//

import Foundation

protocol ClearableLocation: CaseIterable, Codable {
    var url: URL { get }
    var displayName: String { get }
    var persistenceKey: String { get } 
}

extension ClearableLocation {
    var id: String { displayName }
}
