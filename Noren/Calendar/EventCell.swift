//
//  EventCell.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import EventKit
import SwiftUI

struct EventCell: View {
    let event: EKEvent
    let displayDate: Date

    var body: some View {
        HStack {
            Capsule()
                .fill(Color(cgColor: event.calendar.cgColor))
                .frame(width: 4)

            VStack(alignment: .leading) {
                Text(event.title)

                if event.isAllDay {
                    if !Calendar.current.isDate(
                        event.startDate, equalTo: event.endDate,
                        toGranularity: .day)
                    {
                        Text(
                            "\(event.startDate.formattedAllDayForEventCell(displayDate: displayDate)) ~ \(event.endDate.formattedAllDayForEventCell(displayDate: displayDate))"
                        )
                        .font(.caption)
                    }
                } else {
                    Text(
                        "\(event.startDate.formattedNotAllDayForEventCell(displayDate: displayDate)) ~ \(event.endDate.formattedNotAllDayForEventCell(displayDate: displayDate))"
                    )
                    .font(.caption)
                }
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
        .background(
            .gray.opacity(0.2),
            in: RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    let event = EKEvent(eventStore: EKEventStore())
    event.title = "Title"
    event.startDate = Date()
    event.endDate = Date()
    event.calendar = EKCalendar(for: .event, eventStore: EKEventStore())
    event.calendar.cgColor = CGColor(red: 1.0, green: 0, blue: 0, alpha: 1)

    return EventCell(event: event, displayDate: Date())
}
