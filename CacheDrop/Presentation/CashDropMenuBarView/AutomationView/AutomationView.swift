    //
    //  AutomationView.swift
    //  CacheDrop
    //
    //  Created by Fatin on 17/02/26.
    //

import SwiftUI

struct AutomationView: View {
    
    let automationToolTip = "This section is like a robot cleaner for Xcode. It safely throws away old leftover files to make more space and keep things tidy."
    
    @StateObject private var viewModel: AutomationViewModel
    
    init() {
        let repository = DefaultIDEStorageRepository()
        let useCase = DefaultAutomationUseCase(repository: repository)
        _viewModel = StateObject(
            wrappedValue: AutomationViewModel(useCase: useCase)
        )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("Automation")
                    .font(.system(size: 14,
                                  weight: .medium,
                                  design: .default))
              
                
                ToolTipButtonView(toolTip: automationToolTip)
                
                Spacer()
                
            }
            Text("This will only work if CacheDrop is running.")
                .font(.system(size: 12,
                              weight: .regular,
                              design: .default))
            
            DerivedDataAutomationView(setting: $viewModel.derivedDataSetting,
                                      onToggle: { viewModel.toggleDerivedData() }
            )
            
            ArchiveAutomationView(setting: $viewModel.archivesSetting,
                                  onToggle: { viewModel.toggleArchives() }
            )
            
        }
        
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray, lineWidth: 1)
        )
        
    }
}


struct DerivedDataAutomationView: View {

    @Binding var setting: AutomationSetting
    var onToggle: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Clear DerivedData")
                        .font(.system(size: 14,
                                      weight: .medium,
                                      design: .default))

                    Text(setting.formattedNextRun)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                
                Picker("Every", selection: $setting.frequency) {
                    ForEach(CleaningFrequency.allCases, id: \.self) { frequency in
                        Text(frequency.rawValue.capitalized)
                            .tag(frequency)
                    }
                }
                .pickerStyle(.automatic)
                .frame(width: 200)
                .onChange(of: setting.frequency ) {
                    onToggle()
                }
                
            }
            Spacer()
            
            Toggle("", isOn: $setting.isEnabled)
                .toggleStyle(.switch)
                .tint(.red)
                .labelsHidden()
                .padding()
                .onChange(of: setting.isEnabled) {
                    onToggle()
                }
        }
    }
}

struct ArchiveAutomationView: View {
    
    @Binding var setting: AutomationSetting
    var onToggle: () -> Void

    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                HStack{
                    Text("Clear Archives")
                        .font(.system(size: 14,
                                      weight: .medium,
                                      design: .default))
                    
                   
                    Text(setting.formattedNextRun)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                
                Picker("Every", selection: $setting.frequency) {
                    ForEach(CleaningFrequency.allCases, id: \.self) { frequency in
                        Text(frequency.rawValue.capitalized)
                            .tag(frequency)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 200)
                .onChange(of: setting.frequency) {
                    onToggle()
                }
                
                
            }
            Spacer()
            
            Toggle("", isOn: $setting.isEnabled)
                .toggleStyle(.switch)
                .labelsHidden()
                .padding()
                .onChange(of: setting.isEnabled) {
                    onToggle()
                }
        }
    }
}
