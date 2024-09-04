//
//  TodoItemView.swift
//  TodoList
//
//  Created by Mathijs Bernson on 04/09/2024.
//  Copyright © 2024 Q42. All rights reserved.
//

import SwiftUI

struct TodoItemView: View {
    var item: TodoItem

    var body: some View {
        ScrollView {
            GeometryReader { proxy in
                VStack(alignment: .leading) {
                    Text(item.text)
                        .font(.body)
                        .foregroundStyle(.primary)
                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .frame(minWidth: proxy.size.width, minHeight: proxy.size.height, alignment: .topLeading)
            }
        }
        .navigationTitle("Todo item")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TodoItemView(item: .example)
    }
}
