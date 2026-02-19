//
//  BottomButtonView.swift
//  CacheDrop
//
//  Created by Fatin on 19/02/26.
//

import SwiftUI

struct BottomButtonsView: View {
    @ObservedObject var viewModel: CacheDropViewModel

    var appVersionString: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
        return "CacheDrop v\(version)"
    }
    
    var introString: String {
        "CacheDrop is a tool to help you clean files and folders that XCode keeps creating for you. It's like a personal XCode Cleaner, but with more features and customization options. \n\nThis started as a learner's project but I have ended up making it as utility app. Hope this makes your life easy working with XCode.\n Cheers🍻"
    }
    
    var body: some View {
        HStack {
            FeedbackButtonView()
                .help("Share you thoughts")
            
            Text(appVersionString)
                .font(.system(size: 11))
                .foregroundColor(.secondary)
            
            Spacer()
            
            ToolTipButtonView(toolTip: introString, size: 15)
            
            
            Button(action: {
                NSApplication.shared.terminate(nil)
            }) {
                Image(systemName: "xmark.circle")
            }
            .help("Quit")
        }
    }
}

struct FeedbackButtonView: View {
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        Button {
            sendEmail()
        } label: {
            Image(systemName: "heart.fill")
                .foregroundStyle(.red)
        }
    }
    
    private func sendEmail() {
        var components = URLComponents()
        components.scheme = "mailto"
        components.path = "fatin@particle41.com"
        components.queryItems = [
            URLQueryItem(name: "subject", value: "Feedback / Claps"),
            URLQueryItem(name: "body", value: "Hello,")
        ]
        
        if let url = components.url {
            openURL(url)
        }
    }
}
