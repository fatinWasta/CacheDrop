    //
    //  CacheDropMenuBarView.swift
    //  CacheDrop
    //
    //  Created by Fatin on 15/02/26.
    //

import SwiftUI

enum IDEType {
    case xcode
    case androidStudio
}

struct CacheDropMenuBarView: View {
    
    @StateObject private var viewModel: CacheDropViewModel
    
    @State private var selectedTab : IDEType = .xcode

    let menuViewWidth: CGFloat = 500
    
    init(viewModel: CacheDropViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            StorageView(viewModel: viewModel)
            
            TabView(selection: $selectedTab) {
                Tab("Xcode", image: "MenuBarIcon", value: .xcode)  {
                    
                    XcodeView()
                        .frame(width: menuViewWidth - 50)
                }
                
                Tab("Android Studio", systemImage: "paperplane", value: .androidStudio)  {
                    Spacer()
                    AndroidStudioView()
                        .frame(width: menuViewWidth - 50)
                       
                }

            }
            
            BottomButtonsView(viewModel: viewModel)
            
        }
        .padding()
        .frame(width: menuViewWidth)
        .onAppear {
            viewModel.load()
        }
    }
    
}

#Preview {
    CacheDropMenuBarView(viewModel: .preview())
}


struct XcodeView : View {
    
    var body: some View {
        Spacer()
      
        if CacheDropIDEChecker.userMacMachine(has: .xcode) {
            DisplaySizeView(viewModel: DisplaySizeViewModel(repository: DefaultIDEStorageRepository(),
                                                            location: XcodeStorageLocation.derivedData),
                            viewType: .derivedData)
            
            
            ArchivesView()
            
            DeviceSupportView()
            
            AutomationView()
        } else {
            IDENotInstalledView(.xcode)
        }
               
        Spacer()
    }
}

struct AndroidStudioView : View {
    
    var body: some View {
        
        Spacer()
        if CacheDropIDEChecker.userMacMachine(has: .xcode) {
            DisplaySizeView(viewModel: DisplaySizeViewModel(repository: DefaultIDEStorageRepository(),
                                                            location: AndroidStudioStorageLocation.gradleCaches),
                            viewType: .gradle)
            
            DisplaySizeView(viewModel: DisplaySizeViewModel(repository: DefaultIDEStorageRepository(),
                                                            location: AndroidStudioStorageLocation.cacheGoogle),
                            viewType: .cacheGoogle)
            
            DisplaySizeView(viewModel: DisplaySizeViewModel(repository: DefaultIDEStorageRepository(),
                                                            location: AndroidStudioStorageLocation.applicationSupport),
                            viewType: .applicationSupport)
            
            DisplaySizeView(viewModel: DisplaySizeViewModel(repository: DefaultIDEStorageRepository(),
                                                            location: AndroidStudioStorageLocation.logsGoogle),
                            viewType: .logsGoogle)
        } else {
            IDENotInstalledView(.androidStudio)
        }
        
        Spacer()
        
        
    }
}


struct IDENotInstalledView: View {
    let uninstalledIDE: CacheDropIDE
    
    init (_ uninstalledIDE: CacheDropIDE) {
        self.uninstalledIDE = uninstalledIDE
    }
        
    var body: some View {
        VStack {
            Image(uninstalledIDE.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                
            Text(uninstalledIDE.ideNotAvailableError)
                .padding()
        }
        
    }
}
