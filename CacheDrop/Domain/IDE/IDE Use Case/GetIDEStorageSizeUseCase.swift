//
//  GetAndroidStudioStorageSizeUseCase.swift
//  CacheDrop
//
//  Created by Fatin on 19/02/26.
//

public struct GetIDEStorageSizeUseCase {
    private let repository: IDEStorageRepository
    
    init(repository: IDEStorageRepository) {
        self.repository = repository
    }
    
    func execute(for location: any ClearableLocation) async throws -> UInt64 {
        try await repository.size(of: location)
    }
}
