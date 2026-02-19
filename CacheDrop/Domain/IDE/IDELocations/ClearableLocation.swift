//
//  ClearableLocation.swift
//  CacheDrop
//
//  Created by Fatin on 19/02/26.
//

import Foundation

protocol ClearableLocation {
    var url: URL { get }
    var displayName: String { get }
}

extension ClearableLocation {
    var id: String { displayName }
}
