//
//  DataSource.swift
//  Core
//
//  Created by candra on 25/06/22.
//

import Foundation
import RxSwift

public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
}
