//
//  StorageUseCase.swift
//  CacheDrop
//
//  Created by Fatin on 15/02/26.
//

struct GetStorageUseCase {
    
    private let repository: StorageRepository
    
    init(repository: StorageRepository) {
        self.repository = repository
    }
    
    func execute() throws -> StorageInfo {
        try repository.fetchStorage()
    }
}
