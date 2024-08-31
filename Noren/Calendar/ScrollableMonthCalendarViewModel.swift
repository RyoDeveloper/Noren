//
//  ScrollableMonthCalendarViewModel.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import Foundation
import Observation

@Observable
class ScrollableMonthCalendarViewModel {
    var weekdays: [String]

    init() {
        weekdays = Self.calculateWeekdays()
    }

    func setWeekdays() {
        weekdays = Self.calculateWeekdays()
    }

    static func calculateWeekdays() -> [String] {
        let shortWeekdaySymbols = Calendar.current.shortWeekdaySymbols
        return Array(
            shortWeekdaySymbols[
                Calendar.current.firstWeekday
                    - 1..<Calendar.current.shortWeekdaySymbols.count]
                + shortWeekdaySymbols[0..<Calendar.current.firstWeekday - 1])
    }
}
