//
//  DeleteFolderContentsUseCase.swift
//  CacheDrop
//
//  Created by Fatin on 16/02/26.
//

import Foundation

public struct DeleteFolderContentsUseCase {
    
    private let repository: FolderRepository
    
    public init(repository: FolderRepository) {
        self.repository = repository
    }
    
    public func execute(at url: URL) async throws {
        try await repository.deleteContents(of: url)
    }
}
