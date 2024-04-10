//
//  MakeDetailView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import SwiftUI

struct MakeDetailView: View {
    
    // MARK: - Attributes
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: MakeDetailViewModel
    @State private var searchText = ""
    @State private var monthCode = ""
    @State private var pickerChoice = "Models"
    
    init(make: Make) {
        _viewModel = StateObject(wrappedValue: MakeDetailViewModel(make: make))
    }
    
    // MARK: - View
    var body: some View {
        let color = viewModel.colors[viewModel.years.count % viewModel.colors.count]
        NavigationStack {
            VStack {
                // MARK: Header
                VStack(spacing: 5) {
                    // Logo
                    HStack(spacing: 15) {
                        Image("\(viewModel.make.name.filter { $0.isLetter || $0.isNumber || $0.isWhitespace })")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Text(viewModel.make.name)
                            .font(.largeTitle)
                    }
                    
                    // Month
                    HStack {
                        Text("Month Reference:")
                            .bold()
                        
                        Picker("Month Reference", selection: $monthCode) {
                            ForEach(viewModel.months, id: \.code) { item in
                                Text(item.name.capitalized).tag(item.code)
                            }
                        }
                    }
                }
                    
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 5)
                    .foregroundStyle(.accent)
                    .padding(.vertical)
                    
                if viewModel.isUpdating {
                    ProgressView("Loading...")
                        .padding(.vertical)
                        .transition(.opacity)
                        .animation(.easeOut, value: viewModel.isUpdating)
                } else {
                    Picker("", selection: $pickerChoice) {
                        Text("Models").tag("Models")
                        Text("Years").tag("Years")
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    // MARK: Content
                    ScrollView {
                        VStack {
                            if pickerChoice == "Models" {
                                if viewModel.displayedModels.isEmpty {
                                    Text("No data available")
                                } else {
                                    DisplayListView(title: pickerChoice, make: viewModel.make, models: viewModel.displayedModels, monthCode: monthCode)
                                }
                            } else {
                                if viewModel.displayedYears.isEmpty {
                                    Text("No data available")
                                } else {
                                    DisplayListView(title: pickerChoice, make: viewModel.make, years: viewModel.displayedYears, monthCode: monthCode)
                                }
                            }
                        }
                    }
                    .padding()
                    .transition(.slide)
                    .animation(.easeInOut, value: pickerChoice)
                }
                
                Spacer()
            }
            .background(.backgroundSecondary)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: searchText) { _, newValue in
                viewModel.applySearchFilter(newValue)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back", systemImage: "chevron.left") {
                        dismiss()
                    }
                }
            }
        }
        .tint(.accent)
        .navigationBarBackButtonHidden()
        .onAppear {
            Task {
                await viewModel.initializeData()
            }
        }
    }
}

#Preview {
    MakeDetailView(make: Make.makeMock)
}
