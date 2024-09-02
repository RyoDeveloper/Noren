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
    private var viewModel = ScrollableMonthCalendarViewModel()

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
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(years, id: \.self) { year in
                        ForEach(1...12, id: \.self) { month in
                            MonthCalendarView(
                                yearMonth: YearMonth(year: year, month: month),
                                selectedDate: $selectedDate
                            )
                            .padding(8)
                            .padding(.bottom, geometry.safeAreaInsets.bottom)
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
            .ignoresSafeArea(edges: .bottom)
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
        .onReceive(
            NotificationCenter.default.publisher(
                for: NSLocale.currentLocaleDidChangeNotification)
        ) { _ in
            viewModel.setWeekdays()
        }
        .onChange(of: selectedDate) { oldValue, newValue in
            withAnimation {
                scrollPosition = YearMonth(
                    year: newValue.year, month: newValue.month)
            }
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    Text(
                        scrollPosition?.toDate?.formattedMonthYear()
                            ?? " "
                    )
                    .font(.title3)
                    .bold()

                    Spacer()
                }
                .padding(.vertical, 8)
                .padding(.horizontal)

                Divider()
                    .background(Color(.systemBackground))
                    .ignoresSafeArea(edges: .horizontal)

                HStack(spacing: 0) {
                    ForEach(viewModel.weekdays, id: \.self) { weekday in
                        Text(weekday)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)

                Divider()
                    .ignoresSafeArea(edges: .horizontal)
            }
            .background(.bar)
        }
    }
}

#Preview {
    ScrollableMonthCalendarView(
        selectedDate: .constant(YearMonthDay(year: 2025, month: 1, day: 1)))
}
