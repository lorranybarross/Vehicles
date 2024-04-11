//
//  MakeDetailViewModel.swift
//  Vehicles
//
//  Created by Lorrany Barros on 08/04/24.
//

import Foundation
import Combine

class MakeDetailViewModel: ObservableObject {
    @Published var months = [MonthReference]()
    @Published var models = [Model]()
    @Published var displayedModels = [Model]()
    @Published var years = [ModelYear]()
    @Published var displayedYears = [ModelYear]()
    let make: Make
    let colors = Colors.colors.map { $0.color }
    
    private let webService = WebService()
    private var cancellables = Set<AnyCancellable>()
    var viewState = ViewState.loading
    
    init(make: Make) {
        self.make = make
    }
    
    func loadData() {
        // Check cache
        let cachedDataModels = ModelCache.cachedModel()
        let cachedDataYears = YearCache.cachedYear()
        let cachedDataMonths = MonthCache.cachedMonth()
        if let cacheModels = cachedDataModels,
           let cacheYears = cachedDataYears,
           let cacheMonths = cachedDataMonths {
            if cacheModels.count > 0 && cacheYears.count > 0 && cacheMonths.count > 0 {
                models = cacheModels
                displayedModels = models
                years = cacheYears
                displayedYears = years
                months = cacheMonths
                
                self.viewState = .ready
            }
        }
        
        let modelsPublisher = webService.fetchModels(makeCode: make.code)
        let yearsPublisher = webService.fetchYearByMake(makeCode: make.code)
        let monthsPublisher = webService.fetchMonthReference()
        
        Publishers.Zip3(modelsPublisher, yearsPublisher, monthsPublisher)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.viewState = .error
                }
            } receiveValue: { models, years, months in
                self.models = models
                self.displayedModels = self.models
                self.years = years
                self.displayedYears = self.years
                self.months = months
                
                ModelCache.cacheModel(models)
                YearCache.cacheYear(years)
                MonthCache.cacheMonth(months)
                
                self.viewState = .ready
            }
            .store(in: &cancellables)
    }
    
    func applySearchFilter(_ searchText: String) {
        if searchText.isEmpty {
            displayedModels = models
            displayedYears = years
        } else {
            displayedModels = models.filter { $0.name.localizedStandardContains(searchText) }
            displayedYears = years.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
}
