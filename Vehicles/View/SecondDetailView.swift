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
    
    init(title: String, make: Make, model: Model? = nil, year: ModelYear? = nil, monthCode: String) {
        _viewModel = StateObject(wrappedValue: SecondDetailViewModel(make: make, model: model, year: year, monthCode: monthCode))
    }
        
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundSecondary
                    .ignoresSafeArea()
                
                VStack {
                    // MARK: Header
                    HStack(spacing: 15) {
                        Image("\(viewModel.make.name.filter { $0.isLetter || $0.isNumber || $0.isWhitespace })")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Text(viewModel.make.name)
                            .font(.largeTitle)
                    }
                    
                    Text("\(viewModel.make.name) > \(viewModel.model?.name ?? viewModel.year?.yearNameWithZeroKM ?? "")")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                    
                    // MARK: Content
                    ScrollView {
                        if let model = viewModel.model {
                            DisplaySecondListView(title: "Years", make: viewModel.make, model: model, monthCode: viewModel.monthCode, years: viewModel.years)
                        } else if let year = viewModel.year {
                            DisplaySecondListView(title: "Models", make: viewModel.make, year: year, monthCode: viewModel.monthCode, models: viewModel.models)
                        } else {
                            Text("No data available")
                        }
                    }
                    
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
