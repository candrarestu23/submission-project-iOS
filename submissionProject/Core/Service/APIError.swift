//
//  APIError.swift
//  submissionProject
//
//  Created by candra restu on 18/05/22.
//

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
    case localDatabaseError
}

extension APIError: LocalizedError {
    var errorDescription: String? {
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
