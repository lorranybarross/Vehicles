//
//  Model.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import Foundation

class Model: Codable {
    let code, name: String

    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}

extension Model {
    static var modelMock: Model {
        Model(code: "5940", name: "AMAROK High.CD 2.0 16V TDI 4x4 Dies. Aut")
    }
}
