import Foundation
import SwiftUI

public struct MyLibrary {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}

public final class ListFactory {
    public static func create() -> some View {
        ListView(viewModel: .init())
    }
}

struct ListView: View {
    @State var stack: [ListNavigation] = []
    @ObservedObject var viewModel: ListViewModel
    @State var present: Present?
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack(path: $stack) {
            List {
                ForEach(viewModel.items) { item in
                    Button {
                        stack.append(.detail(item))
                    } label: {
                        Text(item.title)
                    }
                    .foregroundColor(.primary)
                }
            }
            .sheet(item: $present, content: { item in
                Text("Add New")
            })
            .navigationTitle(Text("Список"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        present = .add
                    }
                }
            }
            .navigationDestination(for: ListNavigation.self) { item in
                switch item {
                case .details(let id):
                    if let element = viewModel.items.first(where: { $0.id == id }) {
                        VStack {
                            Text(element.title)
                        }
                    }
                case .detail(let item):
                    DetailsView(viewModel: .init(details: item))
                }
            }
        }
    }
    
    enum Present: Identifiable {
        var id: Int {
            self.hashValue
        }
        case add
    }
}

enum ListNavigation: Hashable {
    case details(String)
    case detail(ListItem)
}

struct ListItem: Identifiable, Hashable {
    public let id: String
    let title: String
}
