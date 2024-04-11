//
//  SearchViewModel.swift
//  Vehicles
//
//  Created by Lorrany Barros on 08/04/24.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var makes = [Make]()
    @Published var displayedMakes = [Make]()
    @Published var isShowingGrid = true
    @Published var isSearchingByLetter = false
    @Published var errorMessage = ""
    
    private let webService = WebService()
    private var cancellable: AnyCancellable?
    var viewState = ViewState.loading
    
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    func loadMakes() {
        let cachedData = MakeCache.cachedMake()
        if let cache = cachedData {
            if cache.count > 0 {
                makes = cache
                return
            }
        }
        
        cancellable = webService.fetchMakes()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    if let requestError = error as? RequestError {
                        self.errorMessage = requestError.errorMessage
                    }
                    self.viewState = .error
                }
            }, receiveValue: { makes in
                self.makes = makes
                self.displayedMakes = self.makes
                self.viewState = .ready
                MakeCache.cacheMake(makes)
            })
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
