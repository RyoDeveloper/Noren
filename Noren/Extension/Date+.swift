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
}
