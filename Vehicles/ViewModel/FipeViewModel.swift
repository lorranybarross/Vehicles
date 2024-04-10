//
//  FipeViewModel.swift
//  Vehicles
//
//  Created by Lorrany Barros on 09/04/24.
//

import Foundation

class FipeViewModel: ObservableObject {
    @Published var fipe = Fipe.fipeMock
    @Published var fipeFromPeriod = [Fipe]()
    let make: Make
    let model: Model
    let year: ModelYear
    let monthCode: String
    
    init(make: Make, model: Model, year: ModelYear, monthCode: String) {
        self.make = make
        self.model = model
        self.year = year
        self.monthCode = monthCode
    }
    
    func getData() async {
//        isUpdating = true
        await getFipe()
        await getFipeFromPeriod()
//        isUpdating = false
    }
    
    func getFipe() async {
        do {
            if let response = try await WebService().getFipe(makeCode: make.code, modelCode: model.code, yearCode: year.code, monthCode: monthCode) {
                fipe = response
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getFipeFromPeriod() async {
        do {
            let initialPeriod = (Int(monthCode) ?? 308) - 5
            let finalPeriod = Int(monthCode) ?? 308
            print("initial: \(initialPeriod)")
            print("final: \(finalPeriod)")
            for code in initialPeriod...finalPeriod {
                if let response = try await WebService().getFipe(makeCode: make.code, modelCode: model.code, yearCode: year.code, monthCode: String(code)) {
                    fipeFromPeriod.append(response)
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func percentageVariation() -> Double {
        (fipeFromPeriod.first!.priceAsDouble - fipeFromPeriod.last!.priceAsDouble) / fipeFromPeriod.first!.priceAsDouble
    }
}
