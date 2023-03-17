//
//  File.swift
//  
//
//  Created by Михаил Серегин on 15.03.2023.
//

import Foundation
import SwiftUI
import ServiceLocatorService

struct DetailsView: View {
    @ObservedObject var viewModel: DetailsViewModel
    var body: some View {
        VStack {
            Text(viewModel.details.id)
            Text(viewModel.details.title)
        }
    }
}

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

public final class ServiceFactory {
    public static func getRegistry(/* Опционально передать нужные параметры для создания всех сервисов */) -> ServiceRegistry {
        let registry = ServiceRegistry()
//        registry.register(SomeService(), as: SomeServiceProtocol.self)
        registry.register(SomeBarService(), as: SomeBarServiceProtocol.self)
        return registry
    }
}

public protocol SomeServiceProtocol {
    func foo()
}

public final class SomeService: SomeServiceProtocol {
    public init() {}
    public func foo() {
        print("bar")
    }
}

public protocol SomeBarServiceProtocol {
    func bar()
}

public final class SomeBarService: SomeBarServiceProtocol {
    public init() {}
    public func bar() {
        print("foo")
    }
}

extension Container {
    
}
