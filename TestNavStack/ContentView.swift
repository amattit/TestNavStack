//
//  ContentView.swift
//  TestNavStack
//
//  Created by Михаил Серегин on 12.03.2023.
//

import SwiftUI
import List
import Settings

struct ContentView: View {
    @State var selectedTab: TabNavigation = .list
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabNavigation.allCases, id: \.self) { tab in
                switch tab {
                case .list:
                    ListFactory.create()
                        .tag(tab)
                        .tabItem {
                            Label {
                                Text("List")
                            } icon: {
                                Image(systemName: "list.dash")
                            }
                        }
                case .settings:
                    
                    SettingsView(viewModel: .init())
                        .tag(tab)
                        .tabItem {
                            Label {
                                Text("Settings")
                            } icon: {
                                Image(systemName: "gear")
                            }
                        }
                case .profile:
                    Root<ProfileView, TabNavigation.ProfileNavigation> { stack in
                        ProfileView()
                    }
                    .tag(tab)
                    .tabItem {
                        Label {
                            Text("Profile")
                        } icon: {
                            Image(systemName: "person")
                        }
                    }
                }
            }
        }
    }
}


struct ProfileView: View {
    @State var stack: [TabNavigation.ProfileNavigation] = []
    var body: some View {
        ScrollView {
            Text("Username")
        }
    }
}

struct Root<Content: View, Navigation: Hashable>: View {
    let content: (Binding<[Navigation]>) -> Content
    @State var stack: [Navigation] = []
    
    var body: some View {
        NavigationStack(path: $stack) {
            content($stack)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum TabNavigation: Hashable, CaseIterable {
    case list
    case settings
    case profile
    
    
    
    
    
    enum ProfileNavigation: Hashable {
        
    }
}
