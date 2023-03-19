//
//  File.swift
//  
//
//  Created by Михаил Серегин on 19.03.2023.
//

import Foundation

public protocol SomeBarServiceProtocol {
    func bar()
}

public final class SomeBarService: SomeBarServiceProtocol {
    public init() {}
    public func bar() {
        print("foo")
    }
}

