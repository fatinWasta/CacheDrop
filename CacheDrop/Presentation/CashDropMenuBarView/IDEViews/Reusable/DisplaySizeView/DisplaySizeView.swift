//
//  DisplaySizeView.swift
//  CacheDrop
//
//  Created by Fatin on 19/02/26.
//

import SwiftUI


struct DisplaySizeView: View {
    @ObservedObject private var viewModel: DisplaySizeViewModel
    let title: String
    let toolTip: String

    init(viewModel: DisplaySizeViewModel,
         viewType: ViewType) {
        
        self.viewModel = viewModel
        self.title = viewType.title
        self.toolTip = viewType.toolTip
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14,
                              weight: .medium,
                              design: .default))
           
            ToolTipButtonView(toolTip: toolTip)
            
            Spacer()
            
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
