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
    
    // MARK: - Main View
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundSecondary
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        showFipeView
                        graphView
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    BackButtonView()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .tint(.accent)
        .onAppear {
            viewModel.loadData()
        }
    }
    
    // MARK: - Other Views
    var headerView: some View {
        HStack(spacing: 15) {
            LogoView(imageName: "\(viewModel.make.name.filter { $0.isLetter || $0.isNumber || $0.isWhitespace })")
            
            Text(viewModel.make.name)
                .font(.largeTitle)
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
    
    var errorView: some View {
        VStack {
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
    
    var informationView: some View {
        Group {
            if let fipe = viewModel.fipe {
                InfoRow(title: "Code", systemImage: "number", detail: fipe.codeFipe)
                InfoRow(title: "Make", systemImage: "info.square.fill", detail: fipe.brand.uppercased())
                InfoRow(title: "Model", systemImage: "car.fill", detail: fipe.model)
                InfoRow(title: "Year", systemImage: "calendar", detail: fipe.yearAsString)
                InfoRow(title: "Fuel", systemImage: "fuelpump.fill", detail: fipe.fuel)
            }
        }
    }
    
    var priceView: some View {
        VStack(alignment: .leading) {
            if let fipe = viewModel.fipe {
                Text("Price")
                    .font(.footnote)
                Text("\(fipe.price)")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.accent)
                Text(fipe.referenceMonth.capitalized)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    var graphView: some View {
        VStack {
//            Divider()
//                .padding()
//            Text("Fipe price from the past 6 months")
//                .bold()
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
    
    var fipeView: some View {
        VStack(alignment: .leading, spacing: 20) {
            headerView
            informationView
            priceView
        }
    }
    
    var showFipeView: some View {
        switch viewModel.viewState {
        case .loading:
            return AnyView(loadingView)
        case .ready:
            return AnyView(fipeView)
        case .error:
            return AnyView(errorView)
        }
    }
}

#Preview {
    FipeView(make: Make.makeMock, model: Model.modelMock, year: ModelYear.modelYearMock, monthCode: "308")
}

struct InfoRow: View {
    var title: String
    var systemImage: String
    var detail: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Label(title, systemImage: systemImage)
                .font(.footnote)
            Text(detail)
        }
    }
}
