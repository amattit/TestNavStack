//
//  File.swift
//  
//
//  Created by Михаил Серегин on 16.03.2023.
//

@propertyWrapper
public struct Service<ServiceType> {
    public let locator: ServiceLocator

    public var wrappedValue: ServiceType {
        do {
            return try locator.make(ServiceType.self)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public init(locator: ServiceLocator) {
        self.locator = locator
    }

    public init() {
        self.locator = ServiceLocator.shared
    }
}

public struct Container {
    public let id = ""
}
