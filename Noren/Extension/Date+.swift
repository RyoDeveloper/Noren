//
//  Date+.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import DateTemplates
import Foundation

extension Date {
    func formattedMonthYear() -> String {
        let template = DateTemplate().year().month(.full)
        return template.localizedString(from: self)
    }

    func formattedDayOfWeekAndDay() -> String {
        let template = DateTemplate().dayOfWeek(.full).day()
        return template.localizedString(from: self)
    }

    /// EventCell AllDay
    func formattedAllDayForEventCell(displayDate: Date) -> String {
        let isNotYear = !Calendar.current.isDate(
            self, equalTo: displayDate, toGranularity: .year)
        let isNotMonth = !Calendar.current.isDate(
            self, equalTo: displayDate, toGranularity: .month)
        let isNotDay = !Calendar.current.isDate(
            self, equalTo: displayDate, toGranularity: .day)

        if isNotYear {
            // 年が違う
            // x年x月x日x:xx
            let template = DateTemplate().year().month(.full).day()
            return template.localizedString(from: self)
        } else if isNotMonth {
            // 月が違う
            //x月x日x:xx
            let template = DateTemplate().month(.full).day().hours()
            return template.localizedString(from: self)
        } else if isNotDay {
            // 日が違う
            // x日x:xx
            let template = DateTemplate().day()
            return template.localizedString(from: self)
        } else {
            // 同じ日
            // x:xx
            let template = DateTemplate().day()
            return template.localizedString(from: self)
        }
    }

    /// EventCell NotAllDay
    func formattedNotAllDayForEventCell(displayDate: Date) -> String {
        let isNotYear = !Calendar.current.isDate(
            self, equalTo: displayDate, toGranularity: .year)
        let isNotMonth = !Calendar.current.isDate(
            self, equalTo: displayDate, toGranularity: .month)
        let isNotDay = !Calendar.current.isDate(
            self, equalTo: displayDate, toGranularity: .day)

        if isNotYear {
            // 年が違う
            // x年x月x日x:xx
            let template = DateTemplate().year().month(.full).day().hours()
                .minutes()
            return template.localizedString(from: self)
        } else if isNotMonth {
            // 月が違う
            //x月x日x:xx
            let template = DateTemplate().month(.full).day().hours().minutes()
            return template.localizedString(from: self)
        } else if isNotDay {
            // 日が違う
            // x日x:xx
            let template = DateTemplate().day().hours().minutes()
            return template.localizedString(from: self)
        } else {
            // 同じ日
            // x:xx
            let template = DateTemplate().hours().minutes()
            return template.localizedString(from: self)
        }
    }
}
