//
//  StorageCoordinator.swift
//  CacheDrop
//
//  Created by Fatin on 16/02/26.
//

import SwiftUI
import Combine

@MainActor


final class StorageCoordinator {
    
    @Published private(set) var size: UInt64 = 0
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let location: (any ClearableLocation)?
    private let getSizeUseCase: GetIDEStorageSizeUseCase
    private let clearUseCase: ClearIDEStorageUseCase
    
    private static let formatter: ByteCountFormatter = {
        let f = ByteCountFormatter()
        f.countStyle = .file
        return f
    }()
    
    init(
        location: (any ClearableLocation)?,
        repository: IDEStorageRepository
    ) {
        self.location = location
        self.getSizeUseCase = GetIDEStorageSizeUseCase(repository: repository)
        self.clearUseCase = ClearIDEStorageUseCase(repository: repository)
    }
    
    var sizeText: String {
        Self.formatter.string(fromByteCount: Int64(size))
    }
    
    func load() {
        Task { await fetch() }
    }
    
    private func fetch() async {
        guard let location else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            size = try await getSizeUseCase.execute(for: location)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func clear() {
        Task { await clearAndReload() }
    }
    
    private func clearAndReload() async {
        guard let location else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await clearUseCase.execute(for: location)
            size = try await getSizeUseCase.execute(for: location)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}



//final class StorageCoordinator {
//    
//    @Published private(set) var size: UInt64 = 0
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//    
//    private let location: XcodeStorageLocation?
//    private let getSizeUseCase: GetXcodeStorageSizeUseCase
//    private let clearUseCase: ClearXcodeStorageUseCase
//    
//    private static let formatter: ByteCountFormatter = {
//        let f = ByteCountFormatter()
//        f.countStyle = .file
//        return f
//    }()
//    
//    init(
//        location: XcodeStorageLocation?,
//        repository: IDEStorageRepository
//    ) {
//        self.location = location
//        self.getSizeUseCase = GetXcodeStorageSizeUseCase(repository: repository)
//        self.clearUseCase = ClearXcodeStorageUseCase(repository: repository)
//    }
//    
//    var sizeText: String {
//        Self.formatter.string(fromByteCount: Int64(size))
//    }
//    
//    func load() {
//        Task { await fetch() }
//    }
//    
//    private func fetch() async {
//        guard let location else { return }
//        
//        isLoading = true
//        defer { isLoading = false }
//        
//        do {
//            size = try await getSizeUseCase.execute(for: location)
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//    }
//    
//    func clear() {
//        Task { await clearAndReload() }
//    }
//    
//    private func clearAndReload() async {
//        guard let location else { return }
//        
//        isLoading = true
//        defer { isLoading = false }
//        
//        do {
//            try await clearUseCase.execute(for: location)
//            size = try await getSizeUseCase.execute(for: location)
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//    }
//}
