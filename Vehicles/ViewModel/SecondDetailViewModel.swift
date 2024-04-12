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
    
    private let service = WebService()
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
            guard let url = URL(string: (service.url + "/cars/brands/\(make.code)/years/\(year.code)/models")) else {
                self.errorMessage = "Invalid URL"
                self.viewState = .error
                return
            }
            
            let modelsPublisher = service.fetch(url: url, type: [Model].self)
            
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
            guard let url = URL(string: (service.url + "/cars/brands/\(make.code)/models/\(model.code)/years")) else {
                self.errorMessage = "Invalid URL"
                self.viewState = .error
                return
            }
                        
            let yearsPublisher = service.fetch(url: url, type: [ModelYear].self)
            
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
