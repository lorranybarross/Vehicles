//
//  MonthCache.swift
//  Vehicles
//
//  Created by Lorrany Barros on 11/04/24.
//

import Foundation

struct MonthCache {
    static let monthCache: NSCache = NSCache<NSString, NSData>()
    
    static func cacheMonth(_ months: [MonthReference]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(months) {
            let data = NSData(data: encoded)
            monthCache.setObject(data, forKey: "kMonths" as NSString)
        }
    }
    
    static func cachedMonth() -> [MonthReference]? {
        if let data = monthCache.object(forKey: "kMonths" as NSString) as Data? {
            do {
                let months = try JSONDecoder().decode([MonthReference].self, from: data)
                return months
            } catch {
                print("Failed to decode from cache: \(error)")
            }
        }
        return nil
    }
}
