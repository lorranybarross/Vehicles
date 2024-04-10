//
//  Make.swift
//  Vehicles
//
//  Created by Lorrany Barros on 05/04/24.
//

import Foundation

class Make: Codable {
    let code, name: String

    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}

extension Make {
    static var makeMock: Make {
        Make(code: "59", name: "VW - VolksWagen")
    }
}
