//
//  File.swift
//  
//
//  Created by Михаил Серегин on 19.03.2023.
//

import Foundation

protocol SomeServiceProtocol {
    func foo()
}

final class SomeService1: SomeServiceProtocol {
    init() {}
    func foo() {
        print("bar")
    }
}
