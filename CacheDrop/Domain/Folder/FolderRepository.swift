//
//  FolderRepository.swift
//  CacheDrop
//
//  Created by Fatin on 16/02/26.
//

import Foundation

public protocol FolderRepository {
    func folderSize(at url: URL) async throws -> UInt64
    func deleteContents(of url: URL) async throws
}
