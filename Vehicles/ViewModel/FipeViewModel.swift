//
//  FipeViewModel.swift
//  Vehicles
//
//  Created by Lorrany Barros on 09/04/24.
//

import Foundation
import Combine

class FipeViewModel: ObservableObject {
    @Published var fipe: Fipe?
    @Published var fipeFromPeriod = [Fipe]()
    @Published var errorMessage = ""
    let make: Make
    let model: Model
    let year: ModelYear
    let monthCode: String
    
    private let service = WebService()
    private var cancellables = Set<AnyCancellable>()
    var viewState = ViewState.loading
    
    init(make: Make, model: Model, year: ModelYear, monthCode: String) {
        self.make = make
        self.model = model
        self.year = year
        self.monthCode = monthCode
    }
    
    func loadData() {
        loadFipe()
        getFipeFromPeriod()
        self.viewState = .ready
    }
    
    func loadFipe() {
        guard let url = URL(string: (service.url + "/cars/brands/\(make.code)/models/\(model.code)/years/\(year.code)?reference=\(monthCode)")) else {
            self.errorMessage = "Invalid URL"
            self.viewState = .error
            return
        }
        
        service.fetch(url: url, type: Fipe.self)
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
        }, receiveValue: { fipe in
            self.fipe = fipe
            self.viewState = .ready
        })
        .store(in: &cancellables)
    }
    
    func getFipeFromPeriod() {
        let initialPeriod = Int(monthCode) ?? 308
        var count = 0
        
//        while count < 5 {
//            webService.fetchFipe(
//                makeCode: make.code,
//                modelCode: model.code,
//                yearCode: year.code,
//                monthCode: String(initialPeriod - count)
//            )
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(_):
//                    break
//                }
//            } receiveValue: { fipe in
//                self.fipeFromPeriod.append(fipe)
//            }
//            .store(in: &cancellables)
//            
//            count += 1
//        }
    }
    
//    func getFipeFromPeriod() async {
//        do {
//            let initialPeriod = (Int(monthCode) ?? 308) - 5
//            let finalPeriod = Int(monthCode) ?? 308
//            print("initial: \(initialPeriod)")
//            print("final: \(finalPeriod)")
//            for code in initialPeriod...finalPeriod {
//                if let response = try await WebService().getFipe(makeCode: make.code, modelCode: model.code, yearCode: year.code, monthCode: String(code)) {
//                    fipeFromPeriod.append(response)
//                }
//            }
//        } catch {
//            print("Error: \(error)")
//        }
//    }
//    
//    func percentageVariation() -> Double {
//        (fipeFromPeriod.first!.priceAsDouble - fipeFromPeriod.last!.priceAsDouble) / fipeFromPeriod.first!.priceAsDouble
//    }
}
