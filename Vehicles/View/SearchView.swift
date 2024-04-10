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
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText = ""
        
    // MARK: - View
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: Alphabet Filter
                VStack(alignment: .leading) {
                    Text("Filter by letter")
                        .font(.footnote)
                    AlphabetScrollView(alphabet: alphabet) { letter in
                        viewModel.applyFilter(with: letter)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                .navigationTitle("Browse All Makes")
                .toolbar {
                    // MARK: Change from Grid to List
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                viewModel.isShowingGrid.toggle()
                            }
                        } label: {
                            Label(viewModel.isShowingGrid ? "Grid" : "List",
                                  systemImage: viewModel.isShowingGrid ? "square.grid.2x2" : "list.bullet")
                        }
                    }
                    
                    // MARK: Clear filters
                    if viewModel.isSearchingByLetter {
                        ToolbarItem {
                            Button("Clear Filter") {
                                viewModel.clearFilter()
                            }
                        }
                    }
                }
                
                // MARK: Fetching Data
                if viewModel.isFetchingData {
                    VStack(spacing: 10) {
                        ProgressView("Loading...")
                            .padding(.vertical)
                            .progressViewStyle(.circular)
                            .scaleEffect(1.5, anchor: .center)
                            .animation(.easeInOut(duration: 0.5), value: viewModel.isFetchingData)
                    }
                } else {
                    // MARK: Makes
                    ListOfMakesView(grid: viewModel.isShowingGrid, makes: viewModel.displayedMakes)
                    .searchable(text: $searchText)
                    .onChange(of: searchText) { _, newValue in
                        viewModel.search(for: newValue)
                    }
                    .transition(.opacity.combined(with: .slide))
                }
                
                Spacer()
            }
            .background(.backgroundSecondary)
        }
        .onAppear {
            Task {
                await viewModel.getMakes()
            }
        }
    }
}

#Preview {
    SearchView()
}
