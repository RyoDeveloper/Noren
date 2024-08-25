//
//  DayDetailView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct DayDetailView: View {
    @Binding var selectedDate: YearMonthDay
    @State private var isShowHeaberBackground: Bool = false

    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                Path { _ in
                    DispatchQueue.main.async {
                        isShowHeaberBackground =
                            geometry.frame(in: .named("dayDetailViewScroll"))
                            .origin.y < -16
                    }
                }
            }
            .frame(height: 0)

            Text(
                "\(String(selectedDate.year)) / \(selectedDate.month) / \(selectedDate.day)"
            )
            .frame(maxWidth: .infinity)
        }
        .coordinateSpace(name: "dayDetailViewScroll")
        .overlay(alignment: .bottomTrailing) {
            if let selectedDate = selectedDate.toDate,
                !Calendar.current.isDate(Date(), inSameDayAs: selectedDate)
            {
                Button {
                    withAnimation {
                        let currentDate = Date()
                        let calendar = Calendar.current
                        let year = calendar.component(.year, from: currentDate)
                        let month = calendar.component(
                            .month, from: currentDate)
                        let day = calendar.component(.day, from: currentDate)
                        self.selectedDate = YearMonthDay(
                            year: year, month: month, day: day)
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
                .background(.bar.opacity(isShowHeaberBackground ? 1 : 0))

                Divider()
                    .opacity(isShowHeaberBackground ? 1 : 0)
                    .ignoresSafeArea(edges: .horizontal)
            }
        }
    }
}

#Preview {
    DayDetailView(
        selectedDate: .constant(YearMonthDay(year: 2025, month: 1, day: 1)))
}
