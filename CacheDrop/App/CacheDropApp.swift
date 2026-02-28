//
//  CacheDropApp.swift
//  CacheDrop
//
//  Created by Fatin on 19/02/26.
//

import SwiftUI

@main
struct CacheDropApp: App {
        private let viewModel: CacheDropViewModel
        
        init() {
            let repository = FileManagerStorageRepository()
            let useCase = GetStorageUseCase(repository: repository)
            viewModel = CacheDropViewModel(storageUseCase: useCase)
        }
        
        var body: some Scene {
            MenuBarExtra {
                CacheDropMenuBarView(viewModel: viewModel)
            } label: {
                Image("MenuBarIcon")
            }
            .menuBarExtraStyle(.window)
        }
}
