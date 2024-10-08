//
//  ContentView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import SwiftUI

enum TabItem {
    case highlight
    case calendar
    case reminder
    case note
    case search
}

struct ContentView: View {
    @State var selectedTab: TabItem = .highlight

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("ハイライト", systemImage: "sparkles", value: .highlight) {
                HighlightView()
            }
            Tab("カレンダー", systemImage: "calendar", value: .calendar) {
                CalendarView()
            }
            Tab("リマインダー", systemImage: "checklist", value: .reminder) {
                ReminderView()
            }
            Tab("ノート", systemImage: "note.text", value: .note) {
                NoteView()
            }
            Tab(value: .search, role: .search) {
                SearchView()
            }
        }
    }
}

#Preview {
    ContentView()
}
