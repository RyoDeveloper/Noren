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

    var body: some View {
        ScrollView {
            Text(
                "\(String(selectedDate.year)) / \(selectedDate.month) / \(selectedDate.day)"
            )
            .frame(maxWidth: .infinity)
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Text(String(selectedDate.day))
                    .font(.title3)
                    .bold()

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    DayDetailView(
        selectedDate: YearMonthDay(year: 2025, month: 1, day: 1))
}
