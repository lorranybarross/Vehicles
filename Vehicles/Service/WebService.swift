//
//  WebService.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import Foundation

struct WebService {
    private let baseURL = "https://parallelum.com.br/fipe/api/v2/cars"
    
    func getMakes() async throws -> [Make]? {
        let endpoint = baseURL + "/brands"
        
        guard let url = URL(string: endpoint) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Make].self, from: data)
        
        return result
    }
    
    func getModels(makeCode: String) async throws -> [Model]? {
        let endpoint = baseURL + "/brands/" + makeCode + "/models"
                
        guard let url = URL(string: endpoint) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Model].self, from: data)
        
        return result
    }
    
    func getModelsByMakeAndYear(makeCode: String, yearCode: String) async throws -> [Model]? {
        let endpoint = baseURL + "/brands/" + makeCode + "/years/" + yearCode + "/models"
                        
        guard let url = URL(string: endpoint) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Model].self, from: data)
                
        return result
    }
    
    func getYearsByModel(makeCode: String, modelCode: String) async throws -> [ModelYear]? {
        let endpoint = baseURL + "/brands/" + makeCode + "/models/" + modelCode + "/years"
                        
        guard let url = URL(string: endpoint) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([ModelYear].self, from: data)
                
        return result
    }
    
    func getYearsByMake(makeCode: String) async throws -> [ModelYear]? {
        let endpoint = baseURL + "/brands/" + makeCode + "/years"
                        
        guard let url = URL(string: endpoint) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([ModelYear].self, from: data)
                
        return result
    }
    
    func getFipe(makeCode: String, modelCode: String, yearCode: String, monthCode: String) async throws -> Fipe? {
        let endpoint = baseURL + "/brands/" + makeCode + "/models/" + modelCode + "/years/" + yearCode + "?reference=" + monthCode
                        
        guard let url = URL(string: endpoint) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(Fipe.self, from: data)
                        
        return result
    }
    
    func getMonthReference() async throws -> [MonthReference]? {
        let endpoint = baseURL.split(separator: "/").dropLast().joined(separator: "/") + "/references"
                
        guard let url = URL(string: endpoint) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([MonthReference].self, from: data)
                                
        return result
    }
}
