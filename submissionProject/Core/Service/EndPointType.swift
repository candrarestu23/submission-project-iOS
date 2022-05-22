//
//  EndpointType.swift
//  submissionProject
//
//  Created by candra restu on 18/05/22.
//

import Foundation

protocol EndPointType {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}
