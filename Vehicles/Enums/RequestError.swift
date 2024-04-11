//
//  RequestError.swift
//  Vehicles
//
//  Created by Lorrany Barros on 11/04/24.
//

import Foundation

enum RequestError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case serviceUnavailable
    case unknown
    
    var errorMessage: String {
        switch self {
        case .badRequest:
            return "There seems to be an error with the information you provided. Please check and try again."
        case .unauthorized:
            return "You need to be logged in to see this information. Please log in and try again."
        case .forbidden:
            return "You don't have permission to view this information."
        case .notFound:
            return "We couldn't find the information you're looking for. Please try a different search."
        case .internalServerError:
            return "Something went wrong on our end. Please try again later."
        case .serviceUnavailable:
            return "Our service is currently down for maintenance. Please check back later."
        case .unknown:
            return "An unexpected error occurred. Please try again."
        }
    }
    
    static func handleResponse(_ statusCode: Int) -> Self {
        switch statusCode {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 500:
            return .internalServerError
        case 503:
            return .serviceUnavailable
        default:
            return .unknown
        }
    }
}
