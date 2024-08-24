//
//  DynamicStack.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct DynamicStack<Content: View>: View {
    let axis: Axis
    let spacing: CGFloat?
    let content: () -> Content

    init(
        axis: Axis, spacing: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axis = axis
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        VStack {
            switch axis {
            case .horizontal:
                HStack(spacing: spacing, content: content)
            case .vertical:
                VStack(spacing: spacing, content: content)
            }
        }
    }
}

#Preview {
    DynamicStack(axis: .horizontal) {
        Text("1")
        Text("2")
    }
}
