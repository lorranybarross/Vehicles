//
//  SearchView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import SwiftUI
import Speech

struct SearchView: View {
    
    // MARK: - Attributes
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var index = -1
        
    // MARK: - Main View
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    filterByLetterView
                    showMakesView
                }
                .navigationTitle("Browse All Makes")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        gridToListView
                    }
                    
                    if viewModel.isSearchingByLetter {
                        ToolbarItem {
                            Button("Clear Filter") {
                                viewModel.clearFilter()
                                index = -1
                            }
                        }
                    }
                }
                    
                Spacer()
            }
            .background(.backgroundSecondary)
        }
        .onAppear {
            viewModel.loadMakes()
        }
    }
    
    // MARK: - Other views
    var searchView: some View {
        ListOfMakesView(grid: viewModel.isShowingGrid, makes: viewModel.displayedMakes)
        .searchable(text: $searchText)
        .onChange(of: searchText) { _, newValue in
            viewModel.search(for: newValue)
        }
        .transition(.opacity.combined(with: .slide))
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
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
    
    var showMakesView: some View {
        switch viewModel.viewState {
        case .loading:
            return AnyView(loadingView)
        case .ready:
            return AnyView(searchView)
        case .error:
            return AnyView(errorView)
        }
    }
    
    var gridToListView: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.5)) {
                viewModel.isShowingGrid.toggle()
            }
        } label: {
            Label(viewModel.isShowingGrid ? "Grid" : "List",
                  systemImage: viewModel.isShowingGrid ? "square.grid.2x2" : "list.bullet")
        }
    }
    
    var filterByLetterView: some View {
        VStack(alignment: .leading) {
            Text("Filter by letter")
                .font(.footnote)
            AlphabetFilterScrollView(index: $index, alphabet: viewModel.alphabet) { letter in
                viewModel.applyFilter(with: letter)
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    SearchView()
}
