//
//  ContentView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import SwiftUI

enum TabItem {
    case hailight
    case calendar
    case reminder
    case note
    case search
}

struct ContentView: View {
    @State var selectedTab: TabItem = .hailight

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("ハイライト", systemImage: "sparkles", value: .hailight) {
                Text("ハイライト")
            }
            Tab("カレンダー", systemImage: "calendar", value: .calendar) {
                Text("カレンダー")
            }
            Tab("リマインダー", systemImage: "checklist", value: .reminder) {
                Text("リマインダー")
            }
            Tab("ノート", systemImage: "note.text", value: .note) {
                Text("ノート")
            }
            Tab(value: .search, role: .search) {
                Text("検索")
            }
        }
    }
}

#Preview {
    ContentView()
}
