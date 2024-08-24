//
//  ScrollableMonthCalendarView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import SwiftUI
import SwiftUIIntrospect

struct ScrollableMonthCalendarView: View {
    @Binding var selectedDate: YearMonthDay
    @State private var scrollPosition: YearMonth?
    private let years: [Int]
    private let currentYearMonth: YearMonth

    init(selectedDate: Binding<YearMonthDay>) {
        _selectedDate = selectedDate
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let selectedYearMonth = YearMonth(
            year: selectedDate.wrappedValue.year,
            month: selectedDate.wrappedValue.month)
        scrollPosition = selectedYearMonth
        years = Array(year - 100...year + 100)
        currentYearMonth = YearMonth(year: year, month: month)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(years, id: \.self) { year in
                    ForEach(1...12, id: \.self) { month in
                        MonthCalendarView(
                            yearmonth: YearMonth(year: year, month: month),
                            selectedDate: $selectedDate
                        )
                        .id(YearMonth(year: year, month: month))
                        .containerRelativeFrame(.vertical)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $scrollPosition)
        .introspect(.scrollView, on: .iOS(.v18)) { scrollView in
            scrollView.scrollsToTop = false
        }
        .onChange(of: scrollPosition) { oldValue, newValue in
            guard let newValue else { return }
            if currentYearMonth == newValue {
                let currentDate = Date()
                let calendar = Calendar.current
                let day = calendar.component(.day, from: currentDate)
                selectedDate = YearMonthDay(
                    year: newValue.year, month: newValue.month, day: day)
            } else {
                selectedDate = YearMonthDay(
                    year: newValue.year, month: newValue.month, day: 1)
            }
        }
        .overlay(alignment: .bottomTrailing) {
            if currentYearMonth != scrollPosition {
                Button {
                    withAnimation {
                        scrollPosition = currentYearMonth
                    }
                } label: {
                    Label("今日", systemImage: "arrow.uturn.backward")
                }
                .buttonStyle(.bordered)
                .padding()
            }
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Text(
                    String(scrollPosition?.year ?? 0) + "/"
                        + String(scrollPosition?.month ?? 0)
                )
                .font(.title3)
                .bold()

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ScrollableMonthCalendarView(
        selectedDate: .constant(YearMonthDay(year: 2025, month: 1, day: 1)))
}
