//
//  File.swift
//  
//
//  Created by Михаил Серегин on 16.03.2023.
//

import Foundation

public class ServiceRegistry {
    public enum Error: Swift.Error, LocalizedError {
        case notRegistered(Any.Type)
        
        public var errorDescription: String? {
            switch self {
            case .notRegistered(let type):
                return "Service \(type) not registered"
            }
        }
    }

    private struct ServiceFactory<Service> {
        let block: (() -> Service)

        init(block: @escaping (() -> Service)) {
            self.block = block
        }

        func make() -> Service {
            return block()
        }
    }

    private var factories: [Any] = []

    public init() {

    }

    public init(registry: ServiceRegistry) {
        self.factories = registry.factories
    }
    
    public init(registries: [ServiceRegistry]) {
        self.factories = registries
            .map(\.factories)
            .flatMap { $0 }
    }
    
    internal func add(_ registry: ServiceRegistry) {
        self.factories.append(contentsOf: registry.factories)
    }
    
    internal func add(_ registries: [ServiceRegistry]) {
        registries.forEach {
            add($0)
        }
    }

    public func register<Service>(_ service: Service) {
        register(service, as: type(of: service))
    }

    public func register<Service>(_ service: Service, as serviceType: Service.Type) {
        let factory = ServiceFactory { () -> Service in
            return service
        }

        factories.append(factory)
    }

    public func register<Service>(_ block: @escaping (() -> Service)) {
        let factory = ServiceFactory(block: block)
        factories.append(factory)
    }

    internal func make<Service>(_ serviceType: Service.Type) throws -> Service {
        guard
            let factory = factories.first(where: {($0 is ServiceFactory<Service>)}),
            let service = factory as? ServiceFactory<Service>
        else {
            throw Error.notRegistered(Service.self)
        }
        
        return service.make()
    }
}
