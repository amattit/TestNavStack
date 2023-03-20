//
//  File.swift
//  
//
//  Created by Михаил Серегин on 20.03.2023.
//

import Foundation
import ServiceLocatorService

final class DetailsViewModel: ObservableObject {
    let details: ListItem
    @Service var someService: SomeServiceProtocol
    @Service var someBarService: SomeBarServiceProtocol
    
    init(details: ListItem) {
        self.details = details
        someService.foo()
        someBarService.bar()
    }
}
