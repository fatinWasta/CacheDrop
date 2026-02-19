//
//  DerivedDataView.swift
//  CacheDrop
//
//  Created by Fatin on 16/02/26.
//

import SwiftUI

struct DerivedDataView: View {

    let derivedDataToolTip = "Derived Data is like a folder where Xcode keeps the LEGO pieces it builds for your app. If it gets messy, you can throw it away and Xcode will build fresh LEGO pieces again."
    
    @StateObject private var viewModel = DerivedDataViewModel(
        repository: DefaultIDEStorageRepository()
    )
        
    var body: some View {
        HStack {
            Text("DerivedData")
                .font(.system(size: 14,
                              weight: .medium,
                              design: .default))
           
            ToolTipButtonView(toolTip: derivedDataToolTip)
            
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


