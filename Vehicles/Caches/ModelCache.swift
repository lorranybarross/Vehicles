//
//  ModelCache.swift
//  Vehicles
//
//  Created by Lorrany Barros on 11/04/24.
//

import Foundation

struct ModelCache {
    static let modelCache: NSCache = NSCache<NSString, NSData>()
    
    static func cacheModel(_ models: [Model]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(models) {
            let data = NSData(data: encoded)
            modelCache.setObject(data, forKey: "kModels" as NSString)
        }
    }
    
    static func cachedModel() -> [Model]? {
        if let data = modelCache.object(forKey: "kModels" as NSString) as Data? {
            do {
                let models = try JSONDecoder().decode([Model].self, from: data)
                return models
            } catch {
                print("Failed to decode from cache: \(error)")
            }
        }
        return nil
    }
}
