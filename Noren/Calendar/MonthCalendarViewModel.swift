//
//  MonthCalendarViewModel.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import Foundation
import Observation
import SwiftUI

@Observable
class MonthCalendarViewModel {
    var firstWeekday = Calendar.current.firstWeekday
    var currentDate = YearMonthDay()

    func textColor(
        day: YearMonthDay, selectedDate: YearMonthDay, currentDate: YearMonthDay
    ) -> Color {
        if day == selectedDate {
            // 選択
            return Color(.systemBackground)
        } else if day == currentDate {
            //　今日
            return .accentColor
        } else {
            return .primary
        }
    }

    func textBackgroundColor(
        day: YearMonthDay, selectedDate: YearMonthDay, currentDate: YearMonthDay
    ) -> Color {
        if currentDate == day && day == selectedDate {
            // 今日を選択
            return .accentColor
        } else if day == selectedDate {
            //　選択
            return .primary
        } else {
            return .clear
        }
    }

    func getYearMonthDay(year: Int, month: Int, weekOfMonth: Int, weekday: Int)
        -> YearMonthDay?
    {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.weekOfMonth = weekOfMonth
        components.weekday = adjustWeekday(
            weekday: weekday, firstWeekday: firstWeekday)

        let calendar = Calendar.current
        guard let date = calendar.date(from: components) else { return nil }
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        return YearMonthDay(year: year, month: month, day: day)
    }

    func adjustWeekday(weekday: Int, firstWeekday: Int) -> Int {
        let dayOfWeek = (weekday + firstWeekday - 2) % 7 + 1
        return dayOfWeek <= 0 ? dayOfWeek + 7 : dayOfWeek
    }

    func isShowWeek(
        weekOfMonth: Int, calendarYearMonth: YearMonth
    ) -> Bool {
        guard
            let weekStart = getYearMonthDay(
                year: calendarYearMonth.year, month: calendarYearMonth.month,
                weekOfMonth: weekOfMonth, weekday: 1),
            let weekEnd = getYearMonthDay(
                year: calendarYearMonth.year, month: calendarYearMonth.month,
                weekOfMonth: weekOfMonth, weekday: 7)
        else { return false }

        if weekStart.month != calendarYearMonth.month
            && weekEnd.month != calendarYearMonth.month
        {
            return false
        }

        return true
    }
}
