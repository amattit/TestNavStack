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
