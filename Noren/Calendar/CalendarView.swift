//
//  CalendarView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct YearMonthDay {
    let year: Int
    let month: Int
    let day: Int
}

struct YearMonth: Hashable, Comparable {
    let year: Int
    let month: Int

    static func < (lhs: YearMonth, rhs: YearMonth) -> Bool {
        if lhs.year != rhs.year {
            return lhs.year < rhs.year
        }
        return lhs.month < rhs.month
    }
}

struct CalendarView: View {
    @State private var selectedDate: YearMonthDay

    init() {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        selectedDate = YearMonthDay(year: year, month: month, day: day)
    }

    var body: some View {
        VStack {
            ScrollableMonthCalendarView(selectedDate: $selectedDate)

            Divider()
                .padding(.horizontal)

            DayDetailView(selectedDate: selectedDate)
        }
    }
}

#Preview {
    CalendarView()
}
