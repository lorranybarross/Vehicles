//
//  SecondDetailViewModel.swift
//  Vehicles
//
//  Created by Lorrany Barros on 08/04/24.
//

import Foundation

class SecondDetailViewModel: ObservableObject {
    @Published var models = [Model]()
    @Published var years = [ModelYear]()
    let make: Make
    let model: Model?
    let year: ModelYear?
    let monthCode: String
    
    init(make: Make, model: Model? = nil, year: ModelYear? = nil, monthCode: String) {
        self.make = make
        self.model = model
        self.year = year
        self.monthCode = monthCode
    }
    
    func getData() async {
        if let modelCode = model?.code {
            await getYearsByModel(modelCode: modelCode)
        } else if let yearCode = year?.code {
            await getModelsByMakeAndYear(yearCode: yearCode)
        }
    }
    
    func getModelsByMakeAndYear(yearCode: String) async {
        do {
            if let response = try await WebService().getModelsByMakeAndYear(makeCode: make.code, yearCode: yearCode) {
                models = response
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getYearsByModel(modelCode: String) async {
        do {
            if let response = try await WebService().getYearsByModel(makeCode: make.code, modelCode: modelCode) {
                years = response
            }
        } catch {
            print("Error: \(error)")
        }
    }
}
