//
//  AddView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import SwiftUI

enum AddViewType: String, CaseIterable {
    case event = "イベント"
    case reminder = "リマインダー"
    case note = "ノート"
}

struct AddView: View {
    @Environment(\.dismiss) private var dismiss
    @State var addViewType: AddViewType

    var body: some View {
        Text("AddView")
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("追加")
                            .bold()
                    }

                }

                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("キャンセル")
                    }

                }
            }

            .navigationTitle(addViewType.rawValue)
            .navigationBarTitleDisplayMode(.inline)

            .safeAreaInset(edge: .top) {
                Picker("タブ", selection: $addViewType) {
                    ForEach(AddViewType.allCases, id: \.self) {
                        Text($0.rawValue)
                            .tag($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
    }
}

#Preview {
    NavigationStack {
        AddView(addViewType: .event)
    }
}
