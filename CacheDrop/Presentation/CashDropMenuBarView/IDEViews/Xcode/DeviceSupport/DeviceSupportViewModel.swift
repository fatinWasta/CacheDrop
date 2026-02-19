//
//  DeviceSupportViewModel.swift
//  CacheDrop
//
//  Created by Fatin on 16/02/26.
//


import SwiftUI
import Combine

@MainActor
final class DeviceSupportViewModel: ObservableObject {
    
    @Published private(set) var size: UInt64 = 0
    @Published var isLoading = false
    @Published var errorMessage: String?
   
    @Published var deviceSupports: [DirectoryItem] = []

    private let repository: XcodeDeviceSupportRepository

    private let coordinator: StorageCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: XcodeDeviceSupportRepository) {
        self.repository = repository
        coordinator = StorageCoordinator(
            location: XcodeStorageLocation.deviceSupport,
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
            await fetchDeviceSupport()
        }
    }
    
    func clear() {
        coordinator.clear()
    }
    
    
}

private extension DeviceSupportViewModel {
    func fetchDeviceSupport() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            deviceSupports = try await repository.listXcodeDeviceSupports()
            size = deviceSupports.reduce(0) { $0 + $1.size }
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
