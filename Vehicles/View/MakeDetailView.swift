//
//  MakeDetailView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import SwiftUI

enum PickerChoice: String, CaseIterable {
    case models = "Models"
    case years = "Years"
}

struct MakeDetailView: View {
    
    // MARK: - Attributes
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: MakeDetailViewModel
    @State private var searchText = ""
    @State private var monthCode = ""
    @State private var pickerChoice = PickerChoice.models
    
    init(make: Make) {
        _viewModel = StateObject(wrappedValue: MakeDetailViewModel(make: make))
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundSecondary
                    .ignoresSafeArea()
                
                VStack {
                    headerView
                    showDetailView
                    
                    Spacer()
                }
                .padding()
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
        }
        .tint(.accent)
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.loadData()
        }
    }
    
    // MARK: - Other Views
    var headerView: some View {
        VStack(spacing: 5) {
            // Logo
            HStack(spacing: 15) {
                LogoView(imageName: "\(viewModel.make.name.filter { $0.isLetter || $0.isNumber || $0.isWhitespace })")
                
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
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 5)
                .foregroundStyle(.accent)
                .padding(.vertical)
        }
    }
    
    var loadingView: some View {
        VStack(spacing: 10) {
            ProgressView("Loading...")
                .padding(.vertical)
                .scaleEffect(1.5, anchor: .center)
                .animation(.easeInOut(duration: 0.5), value: viewModel.viewState)
        }
    }
    
    var showContent: some View {
        VStack {
            if pickerChoice == .models {
                if viewModel.displayedModels.isEmpty {
                    Text("No data available")
                } else {
                    ListOfModelsOrYearsView(title: pickerChoice.rawValue, make: viewModel.make, models: viewModel.displayedModels, monthCode: monthCode)
                }
            } else {
                if viewModel.displayedYears.isEmpty {
                    Text("No data available")
                } else {
                    ListOfModelsOrYearsView(title: pickerChoice.rawValue, make: viewModel.make, years: viewModel.displayedYears, monthCode: monthCode)
                }
            }
        }
    }
    
    var detailView: some View {
        VStack {
            Picker("", selection: $pickerChoice) {
                ForEach(PickerChoice.allCases, id: \.self) { choice in
                    Text(choice.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            ScrollView {
                showContent
            }
            .padding()
            .transition(.slide)
            .animation(.easeInOut, value: pickerChoice)
        }
    }
    
    var showDetailView: some View {
        switch viewModel.viewState {
        case .loading:
            return AnyView(loadingView)
        case .ready:
            return AnyView(detailView)
        case .error:
            return AnyView(detailView)
        }
    }
}

#Preview {
    MakeDetailView(make: Make.makeMock)
}
