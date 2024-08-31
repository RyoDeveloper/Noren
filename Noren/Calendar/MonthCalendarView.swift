//
//  MonthCalendarView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct MonthCalendarView: View {
    let yearMonth: YearMonth
    @Binding var selectedDate: YearMonthDay
    private let viewModel = MonthCalendarViewModel()

    var body: some View {
        VStack(spacing: 0) {
            ForEach(1...6, id: \.self) { weekOfMonth in
                if viewModel.isShowWeek(
                    weekOfMonth: weekOfMonth, calendarYearMonth: yearMonth)
                {
                    HStack(spacing: 0) {
                        ForEach(1...7, id: \.self) { weekday in
                            if let day = viewModel.getYearMonthDay(
                                year: yearMonth.year, month: yearMonth.month,
                                weekOfMonth: weekOfMonth, weekday: weekday),
                                yearMonth.month == day.month
                            {
                                Button {
                                    withAnimation {
                                        selectedDate = day
                                    }
                                } label: {
                                    Text(String(day.day))
                                        .foregroundColor(
                                            viewModel.textColor(
                                                day: day,
                                                selectedDate: selectedDate,
                                                currentDate: viewModel
                                                    .currentDate)
                                        )
                                        .padding(4)
                                        .frame(maxWidth: .infinity)
                                        .contentShape(Rectangle())
                                        .background(
                                            viewModel.textBackgroundColor(
                                                day: day,
                                                selectedDate: selectedDate,
                                                currentDate: viewModel
                                                    .currentDate),
                                            in: .circle)
                                }
                                .buttonStyle(.plain)
                            } else {
                                HStack {
                                    Spacer()
                                }
                            }
                        }
                    }

                    HStack(spacing: 0) {
                        ForEach(1...7, id: \.self) { day in
                            if let day = viewModel.getYearMonthDay(
                                year: yearMonth.year, month: yearMonth.month,
                                weekOfMonth: weekOfMonth, weekday: day),
                                yearMonth.month == day.month
                            {
                                Button {
                                    withAnimation {
                                        selectedDate = day
                                    }
                                } label: {
                                    Rectangle()
                                        .fill(.clear)
                                }
                            } else {
                                HStack {
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: NSLocale.currentLocaleDidChangeNotification)
        ) { _ in
            viewModel.firstWeekday = Calendar.current.firstWeekday
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: .NSCalendarDayChanged)
        ) { _ in
            viewModel.currentDate = YearMonthDay()
        }
    }
}

#Preview {
    MonthCalendarView(
        yearMonth: YearMonth(year: 2025, month: 1),
        selectedDate: .constant(YearMonthDay(year: 2025, month: 1, day: 1)))
}
