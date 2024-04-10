//
//  ContentView.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import SwiftUI

struct ContentView: View {
    
    let service = WebService()
    
    @State private var makes = [Make]()
    @State private var models = [Model]()
    @State private var years = [ModelYear]()
    @State private var fipe = Fipe.fipeMock
    @State private var makeCode = "Placeholder"
    @State private var modelCode = "Placeholder"
    @State private var yearCode = "Placeholder"
    @State private var model = ""
    @State private var isGettingFipe = false
    
    func getMakes() async {
        do {
            if let response = try await WebService().getMakes() {
                makes = response
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getModels() async {
        do {
            if let response = try await WebService().getModels(makeCode: makeCode) {
                models = response
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getModelsByMakeAndYear() async {
        do {
            if let response = try await WebService().getModelsByMakeAndYear(makeCode: makeCode, yearCode: yearCode) {
                models = response
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getYearsByModel() async {
        do {
            if let response = try await WebService().getYearsByModel(makeCode: makeCode, modelCode: modelCode) {
                years = response
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getYearsByMake() async {
        do {
            if let response = try await WebService().getYearsByMake(makeCode: makeCode) {
                years = response
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getFipe() async {
        do {
            if let response = try await WebService().getFipe(makeCode: makeCode, modelCode: modelCode, yearCode: yearCode, monthCode: "308") {
                fipe = response
                isGettingFipe = true
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    var body: some View {
        TabView {
//            SearchByPlateView()
//                .tabItem {
//                    Label("Plate", systemImage: "licenseplate")
//                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ContentView()
}
