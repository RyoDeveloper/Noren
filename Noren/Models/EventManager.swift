//
//  EventManager.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import EventKit
import Foundation

final class EventManager {
    public static let shared = EventManager()
    var store = EKEventStore()

    private init() {}

    // MARK: - イベント

    /// 認証ステータスの取得
    func eventsAuthorizationStatus() async -> EKAuthorizationStatus {
        do {
            try await store.requestFullAccessToEvents()
        } catch {
            print(error.localizedDescription)
        }

        return EKEventStore.authorizationStatus(for: .event)
    }

    /// イベントの取得
    func fetchEvent(withStart: Date, end: Date, calendars: [EKCalendar]?) async
        -> [EKEvent]
    {
        let predicate = store.predicateForEvents(
            withStart: withStart, end: end, calendars: calendars)
        return store.events(matching: predicate)
    }

    // MARK: - リマインダー

    /// 認証ステータスの取得
    func reminderAuthorizationStatus() async -> EKAuthorizationStatus {
        do {
            try await store.requestFullAccessToReminders()
        } catch {
            print(error.localizedDescription)
        }

        return EKEventStore.authorizationStatus(for: .reminder)
    }

    /// リマインダーの取得
    func fetchReminder(calendars: [EKCalendar]?) async -> [EKReminder] {
        let predicate = store.predicateForReminders(in: calendars)

        return await withCheckedContinuation { continuation in
            store.fetchReminders(matching: predicate) { reminders in
                continuation.resume(returning: reminders ?? [])
            }
        }
    }
}
