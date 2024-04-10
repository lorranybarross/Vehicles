//
//  MonthReference.swift
//  Vehicles
//
//  Created by Lorrany Barros on 08/04/24.
//

import Foundation

class MonthReference: Codable {
    let code, name: String
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case name = "month"
    }
}

extension MonthReference {
    static var monthReferenceMock: MonthReference {
        MonthReference(code: "308", name: "abril de 2024")
    }
}
