//
//  Fipe.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import Foundation

class Fipe: Codable {
    let brand, codeFipe, fuel, fuelAcronym, model: String
    let modelYear: Int
    let price: String
    let referenceMonth: String
    let vehicleType: Int

    init(brand: String, codeFipe: String, fuel: String, fuelAcronym: String, model: String, modelYear: Int, price: String, referenceMonth: String, vehicleType: Int) {
        self.brand = brand
        self.codeFipe = codeFipe
        self.fuel = fuel
        self.fuelAcronym = fuelAcronym
        self.model = model
        self.modelYear = modelYear
        self.price = price
        self.referenceMonth = referenceMonth
        self.vehicleType = vehicleType
    }
}

extension Fipe {
    static var fipeMock: Fipe {
        Fipe(brand: "VW - VolksWagen",
              codeFipe: "005340-6",
              fuel: "Diesel",
              fuelAcronym: "D",
              model: "AMAROK High.CD 2.0 16V TDI 4x4 Dies. Aut",
              modelYear: 2014,
              price: "R$ 10.000,00",
              referenceMonth: "abril de 2024",
              vehicleType: 1)
    }
    
    var yearAsString: String {
        if modelYear == 32000 {
            return "Zero km"
        }
        return String(modelYear)
    }
    
    var priceAsDouble: Double {
        var newPrice = price.filter { $0.isNumber }
        newPrice.removeLast()
        newPrice.removeLast()
        return Double(newPrice)!
    }
    
    var shortReferenceMonth: String {
        var stringAux = ""
        var month = referenceMonth.split(separator: " ").first!
        switch month {
        case "janeiro":
            stringAux = "01"
        case "fevereiro":
            stringAux = "02"
        case "março":
            stringAux = "03"
        case "abril":
            stringAux = "04"
        case "maio":
            stringAux = "05"
        case "junho":
            stringAux = "06"
        case "julho":
            stringAux = "07"
        case "agosto":
            stringAux = "08"
        case "setembro":
            stringAux = "09"
        case "outubro":
            stringAux = "10"
        case "novembro":
            stringAux = "11"
        default:
            stringAux = "12"
        }
        
        return stringAux + "/" + referenceMonth.split(separator: " ").last!
    }
}
