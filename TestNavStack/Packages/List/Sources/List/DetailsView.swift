//
//  File.swift
//  
//
//  Created by Михаил Серегин on 15.03.2023.
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel: DetailsViewModel
    var body: some View {
        VStack {
            Text(viewModel.details.id)
            Text(viewModel.details.title)
        }
    }
}

