

public struct ServiceLocator {
    public static var shared: ServiceLocator = ServiceLocator()

    public let registry: ServiceRegistry

    public init() {
        let registry = ServiceRegistry()
        self.init(registry: registry)
    }

    public init(registry: ServiceRegistry) {
        self.registry = registry
    }

    public func make<Service>(_ serviceType: Service.Type) throws -> Service {
        let service = try registry.make(Service.self)
        return service
    }
    
    public func add(_ registry: ServiceRegistry) {
        self.registry.add(registry)
    }
    
    public func add(_ registries: [ServiceRegistry]) {
        registries.forEach {
            add($0)
        }
    }
}
