//
//  CalendarView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import RDViewSizer
import SwiftUI

struct YearMonthDay: Equatable {
    let year: Int
    let month: Int
    let day: Int

    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }

    init() {
        let currentDate = Date()
        let calendar = Calendar.current
        year = calendar.component(.year, from: currentDate)
        month = calendar.component(.month, from: currentDate)
        day = calendar.component(.day, from: currentDate)
    }

    var toDate: Date? {
        var dateComponents = DateComponents()
        dateComponents.year = self.year
        dateComponents.month = self.month
        dateComponents.day = self.day

        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }
}

struct YearMonth: Hashable, Comparable {
    let year: Int
    let month: Int

    var toDate: Date? {
        var dateComponents = DateComponents()
        dateComponents.year = self.year
        dateComponents.month = self.month

        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }

    static func < (lhs: YearMonth, rhs: YearMonth) -> Bool {
        if lhs.year != rhs.year {
            return lhs.year < rhs.year
        }
        return lhs.month < rhs.month
    }
}

struct CalendarView: View {
    @State private var selectedDate: YearMonthDay
    @State private var viewSize = CGSize()
    private let viewModel = CalendarViewModel()

    init() {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        selectedDate = YearMonthDay(year: year, month: month, day: day)
    }

    var body: some View {
        DynamicStack(axis: viewSize.primaryAxis, spacing: 0) {
            if CGSize() != viewSize {
                ScrollableMonthCalendarView(selectedDate: $selectedDate)

                Divider()
                    .ignoresSafeArea(edges: .top)

                DayDetailView(
                    selectedDate: $selectedDate,
                    ekCalendarItems: viewModel.ekCalendarItems
                ) {
                    Task {
                        guard let selectedDate = selectedDate.toDate else {
                            return
                        }
                        await viewModel.fetchEvent(
                            date: selectedDate, isRefresh: true)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .RDViewSizer($viewSize)
        .task {
            await viewModel.eventsAuthorizationStatus()
        }
        .onChange(of: selectedDate, initial: true) { oldValue, newValue in
            Task {
                guard let selectedDate = newValue.toDate else { return }
                await viewModel.fetchEvent(date: selectedDate, isRefresh: true)
            }
        }
        .onReceive(
            NotificationCenter.default.publisher(for: .EKEventStoreChanged)
        ) { i in
            Task {
                guard let selectedDate = selectedDate.toDate else { return }
                await viewModel.fetchEvent(date: selectedDate, isRefresh: false)
            }
        }
        .toolbarBackground(
            viewSize.primaryAxis == .horizontal ? .visible : .automatic,
            for: .tabBar)
    }
}

#Preview {
    CalendarView()
}
