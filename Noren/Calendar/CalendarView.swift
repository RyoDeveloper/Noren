//
//  CalendarView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import RDViewSizer
import SwiftUI

struct YearMonthDay {
    let year: Int
    let month: Int
    let day: Int

    var toDate: Date? {
        var dateComponents = DateComponents()
        dateComponents.year = self.year
        dateComponents.month = self.month
        dateComponents.day = self.day

        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }
}

struct YearMonth: Hashable, Comparable {
    let year: Int
    let month: Int

    var toDate: Date? {
        var dateComponents = DateComponents()
        dateComponents.year = self.year
        dateComponents.month = self.month

        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }

    static func < (lhs: YearMonth, rhs: YearMonth) -> Bool {
        if lhs.year != rhs.year {
            return lhs.year < rhs.year
        }
        return lhs.month < rhs.month
    }
}

struct CalendarView: View {
    @State private var selectedDate: YearMonthDay
    @State private var viewSize = CGSize()

    init() {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        selectedDate = YearMonthDay(year: year, month: month, day: day)
    }

    var body: some View {
        DynamicStack(axis: viewSize.primaryAxis, spacing: 0) {
            ScrollableMonthCalendarView(selectedDate: $selectedDate)

            Divider()
                .ignoresSafeArea(edges: .top)

            DayDetailView(selectedDate: selectedDate)
        }
        .RDViewSizer($viewSize)
        .toolbarBackground(
            viewSize.primaryAxis == .horizontal ? .visible : .automatic,
            for: .tabBar)
    }
}

#Preview {
    CalendarView()
}
