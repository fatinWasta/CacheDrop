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
                    Spacer()
                    XcodeView()
                        .frame(width: menuViewWidth - 50)
                }
                
                Tab("Android Studio", systemImage: "paperplane", value: .androidStudio)  {
                    AndroidStudioView()
                       
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
        DerivedDataView()
        
        ArchivesView()
        
        DeviceSupportView()
        
        AutomationView()
    }
}

struct AndroidStudioView : View {
    var body: some View {
        Text("Android Studio View")
    }
}


