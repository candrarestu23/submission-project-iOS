//
//  APIError.swift
//  Core
//
//  Created by candra on 25/06/22.
//

import Foundation

public enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
    case localDatabaseError
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to Decode Object"
        case .errorCode(let code):
            return "\(code) - please try again later"
        case .unknown:
            return "Unknown Error"
        case .localDatabaseError:
            return "Realm Database Error"
        }
    }
}
