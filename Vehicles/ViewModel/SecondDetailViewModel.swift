//
//  SecondDetailViewModel.swift
//  Vehicles
//
//  Created by Lorrany Barros on 08/04/24.
//

import Foundation
import Combine

class SecondDetailViewModel: ObservableObject {
    @Published var models: [Model]?
    @Published var displayedModels: [Model]? = nil
    @Published var years: [ModelYear]?
    @Published var displayedYears: [ModelYear]? = nil
    @Published var errorMessage = ""
    let make: Make
    let model: Model?
    let year: ModelYear?
    let monthCode: String
    
    private let webService = WebService()
    private var cancellable: AnyCancellable?
    var viewState = ViewState.loading
    
    init(make: Make, model: Model? = nil, year: ModelYear? = nil, monthCode: String) {
        self.make = make
        self.model = model
        self.year = year
        self.monthCode = monthCode
    }
    
    func getData() async {
        if let model {
            loadYears()
        } else if let year {
            loadModels()
        }
    }
    
    func loadModels() {
        if let year {
            let modelsPublisher = webService.fetchModelsByMakeAndYear(makeCode: make.code, yearCode: year.code)
            
            cancellable = modelsPublisher
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
                }, receiveValue: { models in
                    self.models = models
                    self.displayedModels = self.models
                    self.viewState = .ready
                })
        }
    }
    
    func loadYears() {
        if let model {
            let yearsPublisher = webService.fetchYearsByModel(makeCode: make.code, modelCode: model.code)
            
            cancellable = yearsPublisher
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
                }, receiveValue: { years in
                    self.years = years
                    self.displayedYears = self.years
                    self.viewState = .ready
                })
        }
    }
    
    func applySearchFilter(_ searchText: String) {
        if searchText.isEmpty {
            displayedModels = models
            displayedYears = years
        } else {
            displayedModels = models?.filter { $0.name.localizedStandardContains(searchText) }
            displayedYears = years?.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
}
