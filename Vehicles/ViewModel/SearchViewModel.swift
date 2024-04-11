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
    @Published var errorMessage: String? = nil
    
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
                    self.errorMessage = "\(error.localizedDescription)"
                    self.viewState = .error
                }
            }, receiveValue: { makes in
                DispatchQueue.main.async {
                    self.makes = makes
                    self.displayedMakes = self.makes
                    self.viewState = .ready
                }
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

struct MakeCache {
    static let makeCache: NSCache = NSCache<NSString, NSData>()
    
    static func cacheMake(_ makes: [Make]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(makes) {
            let data = NSData(data: encoded)
            makeCache.setObject(data, forKey: "kMakes" as NSString)
        }
    }
    
    static func cachedMake() -> [Make]? {
        if let data = makeCache.object(forKey: "kMakes" as NSString) as Data? {
            do {
                let makes = try JSONDecoder().decode([Make].self, from: data)
                return makes
            } catch {
                print("Failed to decode from cache: \(error)")
            }
        }
        return nil
    }
}
