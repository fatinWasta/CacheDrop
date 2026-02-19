//
//  GetXcodeStorageSizeUseCase.swift
//  CacheDrop
//
//  Created by Fatin on 16/02/26.
//

public struct GetXcodeStorageSizeUseCase {
    private let repository: IDEStorageRepository
    
    init(repository: IDEStorageRepository) {
        self.repository = repository
    }
    
    public func execute(for location: XcodeStorageLocation) async throws -> UInt64 {
        try await repository.size(of: location)
    }
}
