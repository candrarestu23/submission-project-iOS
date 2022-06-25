//
//  MovieListMapper.swift
//  Core
//
//  Created by candra on 25/06/22.
//

import Foundation

public protocol MovieListMapper {
    associatedtype Response
    associatedtype Domain
    associatedtype Entity
    
    func transformResponseToDomain(response: Response) -> Domain
    func transformDomainToEntity(domain: Domain) -> [Entity]
    func transformEntityToDomain(entity: [Entity]) -> Domain
}
