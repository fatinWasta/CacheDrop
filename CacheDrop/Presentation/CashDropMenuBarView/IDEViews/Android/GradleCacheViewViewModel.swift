//
//  GradleCacheViewViewModel.swift
//  CacheDrop
//
//  Created by Fatin on 19/02/26.
//

import Combine
import SwiftUI

//@MainActor
//final class GradleCacheViewViewModel: ObservableObject {
//    
//    @Published private(set) var size: UInt64 = 0
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//    
//    private let coordinator: StorageCoordinator
//    private var cancellables = Set<AnyCancellable>()
//    
//    init(repository: IDEStorageRepository) {
//        coordinator = StorageCoordinator(
//            location: .derivedData,
//            repository: repository
//        )
//        
//        bind()
//    }
//    
//    var sizeText: String {
//        coordinator.sizeText
//    }
//    
//    func load() {
//        coordinator.load()
//    }
//    
//    func clear() {
//        coordinator.clear()
//    }
//    
//    private func bind() {
//        coordinator.$size.assign(to: &$size)
//        coordinator.$isLoading.assign(to: &$isLoading)
//        coordinator.$errorMessage.assign(to: &$errorMessage)
//    }
//}
