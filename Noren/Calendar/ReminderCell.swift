//
//  ReminderCell.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import EventKit
import SwiftUI

struct ReminderCell: View {
    let reminder: EKReminder

    var body: some View {
        HStack(alignment: .top) {
            Image(
                systemName: reminder.isCompleted
                    ? "inset.filled.circle" : "circle"
            )
            .bold()
            .foregroundStyle(Color(cgColor: reminder.calendar.cgColor))

            VStack(alignment: .leading) {
                Text(reminder.title)

                if let hour = reminder.dueDateComponents?.hour,
                    let minute = reminder.dueDateComponents?.minute
                {
                    Text(String(hour) + ":" + String(format: "%02d", minute))
                        .font(.caption)
                }

            }
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            .gray.opacity(0.2),
            in: RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    let reminder = EKReminder(eventStore: EKEventStore())
    reminder.title = "Title"
    reminder.calendar = EKCalendar(for: .reminder, eventStore: EKEventStore())
    reminder.calendar.cgColor = CGColor(red: 1.0, green: 0, blue: 0, alpha: 1)

    return ReminderCell(reminder: reminder)
}
