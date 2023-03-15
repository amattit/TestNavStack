//
//  TestNavStackApp.swift
//  TestNavStack
//
//  Created by Михаил Серегин on 12.03.2023.
//

import SwiftUI
import ServiceLocatorService
import List

@main
struct TestNavStackApp: App {
    
    init() {
        let listRegistry = ServiceFactory.getRegistry()
        
        ServiceLocator.shared.add(listRegistry)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
