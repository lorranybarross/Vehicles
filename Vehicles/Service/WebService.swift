//
//  WebService.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import Foundation
import Combine

class WebService {
    private let baseURL = "https://parallelum.com.br/fipe/api/v2/cars"
    
    func fetchMakes() -> AnyPublisher<[Make], Error> {
        let endpoint = baseURL + "/brands"
        let request = URLRequest(url: URL(string: endpoint)!)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ data, response -> Data in
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    throw RequestError.handleResponse(response.statusCode)
                }
                return data
            })
            .decode(type: [Make].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchModels(makeCode: String) -> AnyPublisher<[Model], Error> {
        let endpoint = baseURL + "/brands/" + makeCode + "/models"
        
        let url = URL(string: endpoint)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ data, response -> Data in
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    throw RequestError.handleResponse(response.statusCode)
                }
                return data
            })
            .decode(type: [Model].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchModelsByMakeAndYear(makeCode: String, yearCode: String) -> AnyPublisher<[Model], Error> {
        let endpoint = baseURL + "/brands/" + makeCode + "/years/" + yearCode + "/models"
        
        let url = URL(string: endpoint)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ data, response -> Data in
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    throw RequestError.handleResponse(response.statusCode)
                }
                return data
            })
            .decode(type: [Model].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchYearsByModel(makeCode: String, modelCode: String) -> AnyPublisher<[ModelYear], Error> {
        let endpoint = baseURL + "/brands/" + makeCode + "/models/" + modelCode + "/years"
        
        let url = URL(string: endpoint)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ data, response -> Data in
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    throw RequestError.handleResponse(response.statusCode)
                }
                return data
            })
            .decode(type: [ModelYear].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchYearByMake(makeCode: String) -> AnyPublisher<[ModelYear], Error> {
        let endpoint = baseURL + "/brands/" + makeCode + "/years"
        
        let url = URL(string: endpoint)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ data, response -> Data in
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    throw RequestError.handleResponse(response.statusCode)
                }
                return data
            })
            .decode(type: [ModelYear].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchFipe(makeCode: String, modelCode: String, yearCode: String, monthCode: String) -> AnyPublisher<Fipe, Error> {
        let endpoint = baseURL + "/brands/" + makeCode + "/models/" + modelCode + "/years/" + yearCode + "?reference=" + monthCode
        
        let url = URL(string: endpoint)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ data, response -> Data in
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    throw RequestError.handleResponse(response.statusCode)
                }
                return data
            })
            .decode(type: Fipe.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMonthReference() -> AnyPublisher<[MonthReference], Error> {
        let endpoint = baseURL.split(separator: "/").dropLast().joined(separator: "/") + "/references"
        
        let url = URL(string: endpoint)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ data, response -> Data in
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    throw RequestError.handleResponse(response.statusCode)
                }
                return data
            })
            .decode(type: [MonthReference].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
