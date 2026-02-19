//
//  ClearXcodeStorageUseCase.swift
//  CacheDrop
//
//  Created by Fatin on 16/02/26.
//

struct ClearXcodeStorageUseCase {
    private let repository: IDEStorageRepository
    
     init(repository: IDEStorageRepository) {
        self.repository = repository
    }
    
    public func execute(for location: XcodeStorageLocation) async throws {
        try await repository.delete(location: location)
    }
}
