//
//  ClearAndroidStudioStorageUseCase.swift
//  CacheDrop
//
//  Created by Fatin on 19/02/26.
//

struct ClearIDEStorageUseCase {
    private let repository: IDEStorageRepository
    
     init(repository: IDEStorageRepository) {
        self.repository = repository
    }
    
    public func execute(for location: any ClearableLocation) async throws {
        try await repository.delete(location: location)
    }
}
