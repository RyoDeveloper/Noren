//
//  DayDetailView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import EventKit
import SwiftUI

struct DayDetailView: View {
    @Binding var selectedDate: YearMonthDay
    @State private var isShowHeaderBackground: Bool = false
    var ekCalendarItems: [EKCalendarItem]?
    let refreshable: () -> Void

    var body: some View {
        ScrollView {
            VStack {
                if let ekCalendarItems {
                    ForEach(ekCalendarItems, id: \.self) { item in
                        Text("\(item.title)")
                            .padding(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                .gray.opacity(0.2),
                                in: RoundedRectangle(cornerRadius: 8))
                    }
                } else {
                    ProgressView()
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(alignment: .top) {
                GeometryReader { geometry in
                    Path { _ in
                        DispatchQueue.main.async {
                            isShowHeaderBackground =
                                geometry.frame(
                                    in: .named("dayDetailViewScroll")
                                )
                                .origin.y < -8
                        }
                    }
                }
                .frame(height: 0)
            }
        }.refreshable {
            refreshable()
        }
        .coordinateSpace(name: "dayDetailViewScroll")
        .sensoryFeedback(trigger: selectedDate) { oldValue, newValue in
            .selection
        }
        .overlay {
            if let ekCalendarItems, ekCalendarItems.isEmpty {
                ContentUnavailableView {
                    Label("イベントとタスクはありません", systemImage: "checkmark")
                } actions: {
                    Button {
                    } label: {
                        Label("追加", systemImage: "plus")
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            if let selectedDate = selectedDate.toDate,
                !Calendar.current.isDate(Date(), inSameDayAs: selectedDate)
            {
                Button {
                    withAnimation {
                        self.selectedDate = YearMonthDay()
                    }
                } label: {
                    Label("今日", systemImage: "arrow.uturn.backward")
                }
                .buttonStyle(.bordered)
                .padding()
            }
        }
        .safeAreaInset(edge: .top) {
            VStack(spacing: 0) {
                HStack {
                    Text(selectedDate.toDate?.formattedDayOfWeekAndDay() ?? " ")
                        .font(.title3)
                        .bold()

                    Spacer()

                    Button {

                    } label: {
                        Label("追加", systemImage: "plus")
                            .labelStyle(.iconOnly)
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(.bar.opacity(isShowHeaderBackground ? 1 : 0))

                Divider()
                    .opacity(isShowHeaderBackground ? 1 : 0)
                    .ignoresSafeArea(edges: .horizontal)
            }
        }
    }
}

#Preview {
    DayDetailView(
        selectedDate: .constant(YearMonthDay(year: 2025, month: 1, day: 1))
    ) {}
}
