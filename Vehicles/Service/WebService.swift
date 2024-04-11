//
//  WebService.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import Foundation
import Combine

enum NetworkError: Error {
    case requestError
}

class WebService {
    private let baseURL = "https://parallelum.com.br/fipe/api/v2/cars"
    
    func fetchMakes() -> AnyPublisher<[Make], Error> {
        let endpoint = baseURL + "/brands"
        let request = URLRequest(url: URL(string: endpoint)!)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.requestError
                }
                
                return data
            }
            .decode(type: [Make].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchModels(makeCode: String) -> AnyPublisher<[Model], Error> {
        let endpoint = baseURL + "/brands/" + makeCode + "/models"
        
        let url = URL(string: endpoint)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // Get only data
            .decode(type: [Model].self, decoder: JSONDecoder()) // Decode data to Make
            .receive(on: DispatchQueue.main) // Main thread
            .eraseToAnyPublisher() // Convert to AnyPublisher
    }
    
    func fetchModelsByMakeAndYear(makeCode: String, yearCode: String) -> AnyPublisher<[Model], Error> {
        let endpoint = baseURL + "/brands/" + makeCode + "/years/" + yearCode + "/models"
        
        let url = URL(string: endpoint)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Model].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchYearsByModel(makeCode: String, modelCode: String) -> AnyPublisher<[ModelYear], Error> {
        let endpoint = baseURL + "/brands/" + makeCode + "/models/" + modelCode + "/years"
        
        let url = URL(string: endpoint)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [ModelYear].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchYearByMake(makeCode: String) -> AnyPublisher<[ModelYear], Error> {
        let endpoint = baseURL + "/brands/" + makeCode + "/years"
        
        let url = URL(string: endpoint)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [ModelYear].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getFipe(makeCode: String, modelCode: String, yearCode: String, monthCode: String) async throws -> Fipe? {
        let endpoint = baseURL + "/brands/" + makeCode + "/models/" + modelCode + "/years/" + yearCode + "?reference=" + monthCode
                        
        guard let url = URL(string: endpoint) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(Fipe.self, from: data)
                        
        return result
    }
    
    func fetchMonthReference() -> AnyPublisher<[MonthReference], Error> {
        let endpoint = baseURL.split(separator: "/").dropLast().joined(separator: "/") + "/references"
        
        let url = URL(string: endpoint)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [MonthReference].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
