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
    var ekCalendarItems: [EKCalendarItem]? {
        guard let events, let reminders else {
            return nil
        }
        let items = events + reminders
        return items.sorted(by: { getItemDate($0) < getItemDate($1) })
    }
    var events: [EKCalendarItem]?
    /// 全てのリマインダー
    var allReminders: [EKCalendarItem]?
    /// selectedDateのリマインダー
    var reminders: [EKCalendarItem]?
    let eventManager = EventManager.shared

    func eventsAuthorizationStatus() async {
        let _ = await eventManager.eventsAuthorizationStatus()
    }

    func fetchEvent(date: Date, isRefresh: Bool) async {
        if isRefresh {
            events = nil
        }

        let start = Calendar.current.startOfDay(for: date)
        let end = Calendar.current.endOfDay(for: date)
        events = await eventManager.fetchEvent(
            withStart: start, end: end, calendars: nil)
    }

    func reminderAuthorizationStatus() async {
        let _ = await eventManager.reminderAuthorizationStatus()
    }

    func fetchReminder(date: Date, isRefresh: Bool) async {
        if isRefresh {
            reminders = nil
        }

        if allReminders == nil {
            await fetchAllReminder()
        }

        let calendar = Calendar.current
        let selectedDateComponents = calendar.dateComponents(
            [.year, .month, .day], from: date)

        reminders = allReminders?.compactMap { reminder in
            guard let reminder = reminder as? EKReminder,
                let dueDateComponents = reminder.dueDateComponents?.date
            else {
                return nil
            }

            let reminderComponents = calendar.dateComponents(
                [.year, .month, .day], from: dueDateComponents)
            if selectedDateComponents == reminderComponents {
                return reminder
            }
            return nil
        }
    }

    func fetchAllReminder() async {
        allReminders = await eventManager.fetchReminder(calendars: nil)
    }

    private func getItemDate(_ item: EKCalendarItem) -> Date {
        if let event = item as? EKEvent {
            return event.startDate
        } else if let reminder = item as? EKReminder {
            return reminder.dueDateComponents?.date ?? .distantPast
        }
        return .distantPast
    }
}
