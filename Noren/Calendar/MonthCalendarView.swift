//
//  MonthCalendarView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct MonthCalendarView: View {
    let yearmonth: YearMonth
    @Binding var selectedDate: YearMonthDay

    var body: some View {
        Text("\(String(yearmonth.year))/\(yearmonth.month)")
    }
}

#Preview {
    MonthCalendarView(
        yearmonth: YearMonth(year: 2025, month: 1),
        selectedDate: .constant(YearMonthDay(year: 2025, month: 1, day: 1)))
}
