import Foundation
import SwiftUI

public struct Settings {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}

public struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @State var stack: [SettingsNavigation] = []
    
    public init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack(path: $stack) {
            List {
                ForEach(viewModel.list, id: \.self) { item in
                    Button(item.rawValue) {
                        showNotification()
                    }
                }
            }
            .navigationDestination(for: SettingsNavigation.self) { item in
                switch item {
                case .notification:
                    Text(item.rawValue)
                }
            }
        }
    }
    
    func showNotification() {
        stack.append(.notification)
    }
}

public enum SettingsNavigation: String, Hashable  {
    case notification = "Notification"
}

public class SettingsViewModel: ObservableObject {
    @Published var list = [SettingsNavigation.notification]
    
    public init() {
    }
    
    
}
