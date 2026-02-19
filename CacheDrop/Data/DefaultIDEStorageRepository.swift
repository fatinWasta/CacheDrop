    //
    //  DefaultIDEStorageRepository.swift
    //  CacheDrop
    //
    //  Created by Fatin on 19/02/26.
    //

import Foundation

public final class DefaultIDEStorageRepository : IDEStorageRepository {
    
    private let fileManager: FileManager
    
    public init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
        // MARK: - SIZE
    
    func size(of location: any ClearableLocation) async throws -> UInt64 {
        let url = location.url
        
        guard fileManager.fileExists(atPath: url.path) else {
            return 0
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .utility).async {
                do {
                    var totalSize: UInt64 = 0
                    
                    let keys: Set<URLResourceKey> = [
                        .isRegularFileKey,
                        .isSymbolicLinkKey,
                        .totalFileAllocatedSizeKey
                    ]
                    
                    guard let enumerator = self.fileManager.enumerator(
                        at: url,
                        includingPropertiesForKeys: Array(keys)
                    ) else {
                        continuation.resume(returning: 0)
                        return
                    }
                    
                    for case let fileURL as URL in enumerator {
                        let values = try fileURL.resourceValues(forKeys: keys)
                        
                        if values.isSymbolicLink == true { continue }
                        if values.isRegularFile == true {
                            totalSize += UInt64(values.totalFileAllocatedSize ?? 0)
                        }
                    }
                    
                    continuation.resume(returning: totalSize)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
        // MARK: - DELETE
    
    func delete(location: any ClearableLocation) async throws {
        let url = location.url
        
        guard fileManager.fileExists(atPath: url.path) else {
            return
        }
        
        let contents = try fileManager.contentsOfDirectory(
            at: url,
            includingPropertiesForKeys: nil
        )
        
        for item in contents {
            try fileManager.removeItem(at: item)
        }
    }
}

extension DefaultIDEStorageRepository: XcodeArchiveStorageRepository {
    
    func listXcodeArchives() async throws -> [DirectoryItem] {
        let home = fileManager.homeDirectoryForCurrentUser
        let archivesURL = home.appendingPathComponent("Library/Developer/Xcode/Archives", isDirectory: true)
        
        guard fileManager.fileExists(atPath: archivesURL.path) else {
            return []
        }
        let contents = try fileManager.contentsOfDirectory(at: archivesURL, includingPropertiesForKeys: [.totalFileAllocatedSizeKey, .isDirectoryKey])
        
        return contents.compactMap { url in
            let resourceValues = try? url.resourceValues(forKeys: [.totalFileAllocatedSizeKey])
            let size = UInt64(resourceValues?.totalFileAllocatedSize ?? 0)
            return DirectoryItem(name: url.lastPathComponent, size: size)
        }
    }
    
}

extension DefaultIDEStorageRepository : XcodeDeviceSupportRepository {
    
    func listXcodeDeviceSupports() async throws -> [DirectoryItem] {
        let home = fileManager.homeDirectoryForCurrentUser
        let archivesURL = home.appendingPathComponent("Library/Developer/Xcode/iOS DeviceSupport", isDirectory: true)
        
        guard fileManager.fileExists(atPath: archivesURL.path) else {
            return []
        }
        let contents = try fileManager.contentsOfDirectory(at: archivesURL, includingPropertiesForKeys: [.totalFileAllocatedSizeKey, .isDirectoryKey])
        
        return contents.compactMap { url in
            let resourceValues = try? url.resourceValues(forKeys: [.totalFileAllocatedSizeKey])
            let size = UInt64(resourceValues?.totalFileAllocatedSize ?? 0)
            return DirectoryItem(name: url.lastPathComponent, size: size)
        }
    }
}



