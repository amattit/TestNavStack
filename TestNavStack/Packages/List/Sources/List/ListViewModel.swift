//
//  File.swift
//  
//
//  Created by Михаил Серегин on 20.03.2023.
//

import Foundation
import ServiceLocatorService

class ListViewModel: ObservableObject {
    @Service var otherService: OtherServiceProtocol
    @Published var items: [ListItem] = [
        .init(id: UUID().uuidString, title: "первый"),
        .init(id: UUID().uuidString, title: "второй"),
        .init(id: UUID().uuidString, title: "третий"),
        .init(id: UUID().uuidString, title: "четвертый"),
        .init(id: UUID().uuidString, title: "пятый"),
        .init(id: UUID().uuidString, title: "первый"),
        .init(id: UUID().uuidString, title: "второй"),
        .init(id: UUID().uuidString, title: "третий"),
        .init(id: UUID().uuidString, title: "четвертый"),
        .init(id: UUID().uuidString, title: "пятый"),
        .init(id: UUID().uuidString, title: "первый"),
        .init(id: UUID().uuidString, title: "второй"),
        .init(id: UUID().uuidString, title: "третий"),
        .init(id: UUID().uuidString, title: "четвертый"),
        .init(id: UUID().uuidString, title: "пятый"),
        .init(id: UUID().uuidString, title: "первый"),
        .init(id: UUID().uuidString, title: "второй"),
        .init(id: UUID().uuidString, title: "третий"),
        .init(id: UUID().uuidString, title: "четвертый"),
        .init(id: UUID().uuidString, title: "пятый"),
        .init(id: UUID().uuidString, title: "первый"),
        .init(id: UUID().uuidString, title: "второй"),
        .init(id: UUID().uuidString, title: "третий"),
        .init(id: UUID().uuidString, title: "четвертый"),
        .init(id: UUID().uuidString, title: "пятый"),
        .init(id: UUID().uuidString, title: "первый"),
        .init(id: UUID().uuidString, title: "второй"),
        .init(id: UUID().uuidString, title: "третий"),
        .init(id: UUID().uuidString, title: "четвертый"),
        .init(id: UUID().uuidString, title: "пятый"),
        .init(id: UUID().uuidString, title: "первый"),
        .init(id: UUID().uuidString, title: "второй"),
        .init(id: UUID().uuidString, title: "третий"),
        .init(id: UUID().uuidString, title: "четвертый"),
        .init(id: UUID().uuidString, title: "пятый"),
        .init(id: UUID().uuidString, title: "первый"),
        .init(id: UUID().uuidString, title: "второй"),
        .init(id: UUID().uuidString, title: "третий"),
        .init(id: UUID().uuidString, title: "четвертый"),
        .init(id: UUID().uuidString, title: "пятый"),
    ]
    
    public init() {
        
    }
}
