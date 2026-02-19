    //
    //  CacheDropViewModel.swift
    //  CacheDrop
    //
    //  Created by Fatin on 15/02/26.
    //

import SwiftUI
import Combine

@MainActor
final class CacheDropViewModel: ObservableObject {
    
    @Published private(set) var progressBarValue: Double = 0.0

    private(set) var displayText: String = "--"
    
    private let getStorageUseCase: GetStorageUseCase
    
    init(storageUseCase: GetStorageUseCase) {
        self.getStorageUseCase = storageUseCase
    }
    
    func load() {
        do {
            let storageInfo = try getStorageUseCase.execute()
            displayText = format(storageInfo)
            progressBarValue = getStorageProgressBarValue(from: storageInfo)
        } catch {
            displayText = "Error"
        }
    }
    
   
}

private extension CacheDropViewModel {
    func format(_ info: StorageInfo) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useGB]
        formatter.countStyle = .decimal
        
        let used = formatter.string(fromByteCount: info.usedBytes)
        let total = formatter.string(fromByteCount: info.totalBytes)
        
        return "\(used) / \(total) (\(info.percentage)%)"
    }
    
    func getStorageProgressBarValue(from info: StorageInfo) -> Double {
        progressBarValue = 0
        guard info.totalBytes > 0 else { return 0.0 }
        let ratio = Double(info.usedBytes) / Double(info.totalBytes)
        return min(max(ratio, 0.0), 1.0)
    }
    
}

extension CacheDropViewModel {
    static func preview() -> CacheDropViewModel {
        let mock = MockStorageRepository()
        mock.storage = StorageInfo(
            usedBytes: 256_000_000_000,
            totalBytes: 512_000_000_000
        )
        
        let useCase = GetStorageUseCase(repository: mock)
        let vm = CacheDropViewModel(storageUseCase: useCase)
        vm.load()
        return vm
    }
}
