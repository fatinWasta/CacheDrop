//
//  FileManagerStorageRepository.swift
//  CacheDrop
//
//  Created by Fatin on 15/02/26.
//

import Foundation

final class FileManagerStorageRepository: StorageRepository {
    
    func fetchStorage() throws -> StorageInfo {
        let values = try URL(fileURLWithPath: "/")
            .resourceValues(forKeys: [
                .volumeTotalCapacityKey,
                .volumeAvailableCapacityKey
            ])
        
        guard let total = values.volumeTotalCapacity,
              let free = values.volumeAvailableCapacity
        else {
            throw StorageError.unavailable
        }
        
        return StorageInfo(
            usedBytes: Int64(total - free),
            totalBytes: Int64(total)
        )
    }
}

enum StorageError: Error {
    case unavailable
}
