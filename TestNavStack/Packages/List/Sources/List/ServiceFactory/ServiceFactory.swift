//
//  File.swift
//  
//
//  Created by Михаил Серегин on 19.03.2023.
//

import Foundation
import ServiceLocatorService

public final class ServiceFactory {
    public static func getRegistry(/* Опционально передать нужные параметры для создания всех сервисов */) -> ServiceRegistry {
        let registry = ServiceRegistry()
        registry.register(SomeService1(), as: SomeServiceProtocol.self)
        registry.register(SomeBarService(), as: SomeBarServiceProtocol.self)
        return registry
    }
}
