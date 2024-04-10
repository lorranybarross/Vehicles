//
//  MakeDetailViewModel.swift
//  Vehicles
//
//  Created by Lorrany Barros on 08/04/24.
//

import Foundation

class MakeDetailViewModel: ObservableObject {
    @Published var months = [MonthReference]()
    @Published var models = [Model]()
    @Published var displayedModels = [Model]()
    @Published var years = [ModelYear]()
    @Published var displayedYears = [ModelYear]()
    @Published var isUpdating = false
    let make: Make
    let colors = Colors.colors.map { $0.color }
    
    init(make: Make) {
        self.make = make
    }
    
    func initializeData() async {
        isUpdating = true
        await getModels()
        await getYearsByMake()
        await getMonthReference()
        isUpdating = false
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
    
    func getModels() async {
        do {
            if let response = try await WebService().getModels(makeCode: make.code) {
                models = response
                displayedModels = models
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getYearsByMake() async {
        do {
            if let response = try await WebService().getYearsByMake(makeCode: make.code) {
                years = response
                displayedYears = years
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getMonthReference() async {
        do {
            if let response = try await WebService().getMonthReference() {
                months = response
                months = response
            }
        } catch {
            print("Error: \(error)")
        }
    }
}
