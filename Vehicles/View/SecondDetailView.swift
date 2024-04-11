//
//  SecondDetailView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 07/04/24.
//

import SwiftUI

struct SecondDetailView: View {
    
    // MARK: - Attributes
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: SecondDetailViewModel
    @State private var searchText = ""
    
    init(title: String, make: Make, model: Model? = nil, year: ModelYear? = nil, monthCode: String) {
        _viewModel = StateObject(wrappedValue: SecondDetailViewModel(make: make, model: model, year: year, monthCode: monthCode))
    }
    
    // MARK: - Main View
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundSecondary
                    .ignoresSafeArea()
                
                VStack {
                    headerView
                    contentView
                    
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
            Task {
                await viewModel.getData()
            }
        }
    }
    
    // MARK: - Other Views
    var headerView: some View {
        VStack {
            HStack(spacing: 15) {
                LogoView(imageName:
                            "\(viewModel.make.name.filter { $0.isLetter || $0.isNumber || $0.isWhitespace })")
                
                Text(viewModel.make.name)
                    .font(.largeTitle)
            }
            
            Text("\(viewModel.make.name) > \(viewModel.model?.name ?? viewModel.year?.yearNameWithZeroKM ?? "")".uppercased())
                .multilineTextAlignment(.center)
                .font(.headline)
                .padding()
                .clipShape(.rect(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.accent)
                )
        }
    }
    
    var contentView: some View {
        ScrollView {
            if let model = viewModel.model {
                DisplaySecondListView(title: "Years", make: viewModel.make, model: model, monthCode: viewModel.monthCode, years: viewModel.displayedYears)
            } else if let year = viewModel.year {
                DisplaySecondListView(title: "Models", make: viewModel.make, year: year, monthCode: viewModel.monthCode, models: viewModel.displayedModels)
            } else {
                Text("No data available")
            }
        }
    }
}

#Preview {
    SecondDetailView(title: "Years", make: Make.makeMock, monthCode: "308")
}
