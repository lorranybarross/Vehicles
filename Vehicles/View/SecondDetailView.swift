//
//  SecondListOfModelsOrYearsView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 07/04/24.
//

import SwiftUI

struct SecondDetailView: View {
    
    // MARK: - Attributes
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: SecondDetailViewModel
    
    init(title: String, make: Make, model: Model? = nil, year: ModelYear? = nil, monthCode: String) {
        _viewModel = StateObject(wrappedValue: SecondDetailViewModel(make: make, model: model, year: year, monthCode: monthCode))
    }
    
    var headerView: some View {
        VStack {
            HStack(spacing: 15) {
                LogoView(imageName:
                            "\(viewModel.make.name.filter { $0.isLetter || $0.isNumber || $0.isWhitespace })")
                
                Text(viewModel.make.name)
                    .font(.largeTitle)
            }
            
            Text("\(viewModel.make.name) > \(viewModel.model?.name ?? viewModel.year?.yearNameWithZeroKM ?? "")")
                .multilineTextAlignment(.center)
                .font(.headline)
        }
    }
    
    var contentView: some View {
        ScrollView {
            if let model = viewModel.model {
                DisplaySecondListView(title: "Years", make: viewModel.make, model: model, monthCode: viewModel.monthCode, years: viewModel.years)
            } else if let year = viewModel.year {
                DisplaySecondListView(title: "Models", make: viewModel.make, year: year, monthCode: viewModel.monthCode, models: viewModel.models)
            } else {
                Text("No data available")
            }
        }
    }
        
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
}

#Preview {
    SecondDetailView(title: "Years", make: Make.makeMock, monthCode: "308")
}
