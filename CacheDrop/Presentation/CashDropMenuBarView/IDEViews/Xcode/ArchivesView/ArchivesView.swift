    //
    //  ArchivesView.swift
    //  CacheDrop
    //
    //  Created by Fatin on 16/02/26.
    //

import SwiftUI

struct ArchivesView: View {
    
    let arhiveToolTip = "Archives are like a finished toy you carefully pack into a box so you can keep it safe or give it to someone later. Xcode saves these boxes so you can send your app to the App Store or reinstall it anytime."
    
    @StateObject private var viewModel = ArchivesViewModel(
        repository: DefaultIDEStorageRepository()
    )
    
    @State private var isExpanded = false
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Text("Archives (All)")
                    .font(.system(size: 14,
                                  weight: .medium,
                                  design: .default))
                
                ToolTipButtonView(toolTip: arhiveToolTip)
                
                Spacer()
                
                
                if viewModel.isLoading {
                    ProgressView("")
                        .scaleEffect(0.5)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .transition(.opacity)
                        .animation(.easeInOut, value: viewModel.isLoading)
                } else {
                    Text(viewModel.sizeText)
                        .font(.system(size: 11,
                                      weight: .medium,
                                      design: .default))
                    Button(action: {
                        viewModel.clear()
                    }) {
                        Image(systemName: "trash")
                    }
                }
                
            }
            
            Text(viewModel.getArchiveCountText())
            
        }
        
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray, lineWidth: 1)
        )
        .task {
            viewModel.load()
        }
    }
}
