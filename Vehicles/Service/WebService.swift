//
//  WebService.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import Alamofire
import Combine
import Foundation

class WebService {
    let url = "https://parallelum.com.br/fipe/api/v2"
    
    func fetch<T: Decodable>(url: URL, type: T.Type) -> AnyPublisher<T, Error> {
        return AF.request(url)
            .publishDecodable(type: type, decoder: JSONDecoder())
            .tryMap { response -> T in
                if let result = response.response?.statusCode, result != 200 {
                    throw RequestError.handleResponse(result)
                }
                
                guard let data = response.value else {
                    throw RequestError.unknown
                }
                
                return data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
