//
//  File.swift
//  
//
//  Created by Михаил Серегин on 19.03.2023.
//

import Foundation

public protocol SomeServiceProtocol {
    func foo()
}

public final class SomeService: SomeServiceProtocol {
    public init() {}
    public func foo() {
        print("bar")
    }
}
