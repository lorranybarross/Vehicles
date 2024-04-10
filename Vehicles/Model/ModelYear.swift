//
//  ModelYear.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import Foundation

class ModelYear: Codable {
    let code, name: String

    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}

extension ModelYear {
    static var modelYearMock: ModelYear {
        ModelYear(code: "2014-3", name: "2014 Diesel")
    }
    
    var yearNameWithZeroKM: String {
        if name.hasPrefix("32000") {
            return "Zero KM " + name.split(separator: " ").last!
        }
        return name
    }
}
