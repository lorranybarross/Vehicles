//
//  YearCache.swift
//  Vehicles
//
//  Created by Lorrany Barros on 11/04/24.
//

import Foundation

struct YearCache {
    static let yearCache: NSCache = NSCache<NSString, NSData>()
    
    static func cacheYear(_ years: [ModelYear]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(years) {
            let data = NSData(data: encoded)
            yearCache.setObject(data, forKey: "kYears" as NSString)
        }
    }
    
    static func cachedYear() -> [ModelYear]? {
        if let data = yearCache.object(forKey: "kYears" as NSString) as Data? {
            do {
                let years = try JSONDecoder().decode([ModelYear].self, from: data)
                return years
            } catch {
                print("Failed to decode from cache: \(error)")
            }
        }
        return nil
    }
}
