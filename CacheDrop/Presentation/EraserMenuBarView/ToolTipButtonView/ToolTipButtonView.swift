//
//  ToolTipButtonView.swift
//  CacheDrop
//
//  Created by Fatin on 16/02/26.
//

import SwiftUI

struct ToolTipButtonView: View {
    @State private var showPopover = false

    var toolTip: String
    var size: CGFloat = 12
    
    init(toolTip: String, size: CGFloat? = nil) {
        self.toolTip = toolTip
        self.size = size ?? self.size
    }
    
    @ViewBuilder
    var body: some View {
        Button(action: {
            showPopover.toggle()
        }) {
            Image(systemName: "info.circle")
                .font(.system(size: size))
        }
        .buttonStyle(.plain)
        .popover(isPresented: $showPopover, arrowEdge: .bottom) {
            Text(toolTip)
                .font(.system(.caption))
                .padding()
                .frame(width: 300)
        }
    }
}
