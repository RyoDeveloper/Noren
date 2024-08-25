//
//  DayDetailView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct DayDetailView: View {
    let selectedDate: YearMonthDay
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
        selectedDate: YearMonthDay(year: 2025, month: 1, day: 1))
}
