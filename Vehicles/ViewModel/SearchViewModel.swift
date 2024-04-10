//
//  SearchViewModel.swift
//  Vehicles
//
//  Created by Lorrany Barros on 08/04/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var makes = [Make]()
    @Published var displayedMakes = [Make]()
    @Published var isFetchingData = false
    @Published var isShowingGrid = true
    @Published var isSearchingByLetter = false
    
    func getMakes() async {
        self.isFetchingData = true
        defer { self.isFetchingData = false }
        
        do {
            if let response = try await WebService().getMakes() {
                self.makes = response
                self.displayedMakes = self.makes
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func applyFilter(with letter: String) {
        guard !letter.isEmpty else {
            displayedMakes = makes
            return
        }
        displayedMakes = makes.filter { $0.name.starts(with: letter) }
        isSearchingByLetter = true
    }
    
    func clearFilter() {
        displayedMakes = makes
        isSearchingByLetter = false
    }
    
    func search(for query: String) {
        if query.isEmpty {
            displayedMakes = makes
        } else {
            displayedMakes = makes.filter { $0.name.localizedStandardContains(query) }
        }
    }
}
