//
//  CalendarViewModel.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import EventKit
import Foundation
import Observation

@Observable
class CalendarViewModel {
    var ekCalendarItems: [EKCalendarItem]?
    let eventManager = EventManager.shared

    func eventsAuthorizationStatus() async {
        let _ = await eventManager.eventsAuthorizationStatus()
    }

    func fetchEvent(date: Date, isRefresh: Bool) async {
        if isRefresh {
            ekCalendarItems = nil
        }

        let start = Calendar.current.startOfDay(for: date)
        let end = Calendar.current.endOfDay(for: date)
        ekCalendarItems = await eventManager.fetchEvent(
            withStart: start, end: end, calendars: nil)
    }
}
