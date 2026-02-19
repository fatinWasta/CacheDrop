    //
    //  DeviceSupportView.swift
    //  CacheDrop
    //
    //  Created by Fatin on 16/02/26.
    //

import SwiftUI

struct DeviceSupportView: View {
    
    let deviceSupportToolTip = "Device Support files are like special instruction books that help Xcode understand your iPhone. When you plug in a new device or update iOS, Xcode keeps these books to talk to it properly."
    
    @State private var isExpanded = false
    
    @StateObject private var viewModel = DeviceSupportViewModel(
        repository: DefaultIDEStorageRepository()
    )
    
    var body: some View {
        VStack{
            HStack {
                Text("Device Support Files")
                    .font(.system(size: 14,
                                  weight: .medium,
                                  design: .default))
                
                ToolTipButtonView(toolTip: deviceSupportToolTip)
                
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
            
            if !viewModel.deviceSupports.isEmpty {
                DisclosureGroup(isExpanded: $isExpanded) {
                    LazyVStack(alignment: .leading, spacing: 4) {
                        ForEach(viewModel.deviceSupports) { item in
                            Text(item.name)
                                .font(.system(size: 11))
                        }
                    }
                    .padding(.leading, 16)
                    .animation(nil, value: viewModel.deviceSupports.count)
                } label: {
                    Text("Versions")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color("AccentColor"))
                }
                .padding(.top, 4)
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
