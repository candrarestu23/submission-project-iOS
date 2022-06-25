//
//  MovieDetailMapper.swift
//  Core
//
//  Created by candra on 25/06/22.
//

import Foundation
import Foundation
public protocol MovieDetailMapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToDomain(response: Response) -> Domain
    func transformDomainToEntity(domain: Domain) -> Entity
    func transformEntityToDomain(domain: Entity) -> Domain
}
