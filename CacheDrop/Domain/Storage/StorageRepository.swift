//
//  StorageRepository.swift
//  CacheDrop
//
//  Created by Fatin on 15/02/26.
//

protocol StorageRepository {
    func fetchStorage() throws -> StorageInfo
}

final class MockStorageRepository: StorageRepository {
    
    var storage: StorageInfo?
    
    func fetchStorage() throws -> StorageInfo {
        guard let storage else {
            throw StorageError.unavailable
        }
        return storage
    }
}
