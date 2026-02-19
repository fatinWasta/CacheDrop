//
//  StorageInfo.swift
//  CacheDrop
//
//  Created by Fatin on 15/02/26.
//

struct StorageInfo: Equatable {
    let usedBytes: Int64
    let totalBytes: Int64
    
    var percentage: Int {
        guard totalBytes > 0 else { return 0 }
        return Int((Double(usedBytes) / Double(totalBytes)) * 100)
    }
}
