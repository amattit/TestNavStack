//
//  File.swift
//  
//
//  Created by Михаил Серегин on 20.03.2023.
//

import Foundation

protocol OtherServiceProtocol {
    func test()
}

final class OtherService: OtherServiceProtocol {
    func test() {
        print("test")
    }
}
