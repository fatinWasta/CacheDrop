//
//  StorageView.swift
//  CacheDrop
//
//  Created by Fatin on 16/02/26.
//

import SwiftUI

struct StorageView: View {
    @ObservedObject var viewModel: CacheDropViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Mac Storage Usage")
                   .font(.headline)
                Button(action: {
                    viewModel.load()
                }) {
                    Image(systemName: "arrow.trianglehead.counterclockwise")
                }
                .buttonStyle(.plain)
                
                .help("Refresh Storage")
            }
            
            ProgressView(value: viewModel.progressBarValue)
                .progressViewStyle(.linear)
                .controlSize(.mini)
            
            Text(viewModel.displayText)
                .font(.system(size: 11,
                              weight: .medium,
                              design: .default))
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
