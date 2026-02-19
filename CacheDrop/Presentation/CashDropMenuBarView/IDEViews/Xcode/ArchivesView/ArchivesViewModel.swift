    //
    //  ArchivesViewModel.swift
    //  CacheDrop
    //
    //  Created by Fatin on 16/02/26.
    //
import SwiftUI
import Combine

struct DirectoryItem: Identifiable {
    let id = UUID()
    let name: String
    let size: UInt64
}

@MainActor
final class ArchivesViewModel: ObservableObject {
    
    @Published private(set) var size: UInt64 = 0
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var archiveItems: [DirectoryItem] = [] 
    
    private let repository: XcodeArchiveStorageRepository
    private let coordinator: StorageCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: XcodeArchiveStorageRepository) {
        self.repository = repository
        coordinator = StorageCoordinator(
            location: XcodeStorageLocation.archives,
            repository: repository
        )
        
        bind()
    }
    
    var sizeText: String {
        coordinator.sizeText
    }
    
    func load() {
        coordinator.load()
        Task {
            await fetchArchives()
        }
    }
    
    func clear() {
        coordinator.clear()
    }
    
    func getArchiveCountText() -> String {
        return archiveItems.count > 0 ? "Found \(archiveItems.count) archives" : "No archives found"
    }
    
}

private extension ArchivesViewModel {
    
    func fetchArchives() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            archiveItems = try await repository.listXcodeArchives()
            size = archiveItems.reduce(0) { $0 + $1.size }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func bind() {
        coordinator.$size.assign(to: &$size)
        coordinator.$isLoading.assign(to: &$isLoading)
        coordinator.$errorMessage.assign(to: &$errorMessage)
    }
}
