//
//  MakeCache.swift
//  Vehicles
//
//  Created by Lorrany Barros on 11/04/24.
//

import Foundation

struct MakeCache {
    static let makeCache: NSCache = NSCache<NSString, NSData>()
    
    static func cacheMake(_ makes: [Make]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(makes) {
            let data = NSData(data: encoded)
            makeCache.setObject(data, forKey: "kMakes" as NSString)
        }
    }
    
    static func cachedMake() -> [Make]? {
        if let data = makeCache.object(forKey: "kMakes" as NSString) as Data? {
            do {
                let makes = try JSONDecoder().decode([Make].self, from: data)
                return makes
            } catch {
                print("Failed to decode from cache: \(error)")
            }
        }
        return nil
    }
}
