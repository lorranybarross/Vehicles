//
//  FipeView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 09/04/24.
//

import SwiftUI
import Charts

struct FipeView: View {
    
    // MARK: - Attributes
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: FipeViewModel
    
    init(make: Make, model: Model, year: ModelYear, monthCode: String) {
        _viewModel = StateObject(wrappedValue: FipeViewModel(make: make, model: model, year: year, monthCode: monthCode))
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundSecondary
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Logo
                        HStack(spacing: 15) {
                            Image("\(viewModel.make.name.filter { $0.isLetter || $0.isNumber || $0.isWhitespace })")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            Text(viewModel.make.name)
                                .font(.largeTitle)
                        }
                        
                        Group {
                            InfoRow(title: "Code", detail: viewModel.fipe.codeFipe)
                            InfoRow(title: "Make", detail: viewModel.fipe.brand.uppercased())
                            InfoRow(title: "Model", detail: viewModel.fipe.model)
                            InfoRow(title: "Year", detail: viewModel.fipe.yearAsString)
                            InfoRow(title: "Fuel", detail: viewModel.fipe.fuel)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Price")
                                .font(.footnote)
                            Text("\(viewModel.fipe.price)")
                                .font(.title)
                                .bold()
                                .foregroundStyle(.accent)
                            Text(viewModel.fipe.referenceMonth.capitalized)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Divider()
                        
                        VStack {
                            Text("Fipe price from the past 6 months")
                                .bold()
                            Chart(viewModel.fipeFromPeriod, id: \.referenceMonth) { period in
                                LineMark(
                                    x: .value("Month", period.shortReferenceMonth),
                                    y: .value("Price", period.priceAsDouble)
                                )
                                PointMark(
                                    x: .value("Month", period.shortReferenceMonth),
                                    y: .value("Price", period.priceAsDouble)
                                )
                            }
                            .frame(height: 200)
                            .foregroundStyle(.accent)
                        }
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back", systemImage: "chevron.left") {
                        dismiss()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .tint(.accent)
        .onAppear {
            Task {
                await viewModel.getData()
            }
        }
    }
}

#Preview {
    FipeView(make: Make.makeMock, model: Model.modelMock, year: ModelYear.modelYearMock, monthCode: "308")
}

struct InfoRow: View {
    var title: String
    var detail: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.footnote)
            Text(detail)
        }
    }
}
