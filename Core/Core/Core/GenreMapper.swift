//
//  GenreMapper.swift
//  Core
//
//  Created by candra on 25/06/22.
//

import Foundation

public protocol GenreMapper {
    associatedtype Response
    associatedtype Domain
    
    func transformResponseToDomain(response: [Response]) -> [Domain]
}
