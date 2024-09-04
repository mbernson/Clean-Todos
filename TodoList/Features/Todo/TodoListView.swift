//
//  TodoListView.swift
//  TodoList
//
//  Created by Mathijs Bernson on 04/09/2024.
//  Copyright © 2024 Q42. All rights reserved.
//

import SwiftUI

struct TodoListView: View {
    @State var viewModel = TodoListViewModel()
    @State var addTodoItemSheetPresented = false

    var body: some View {
        NavigationStack {
            TodoListContentView(viewModel: $viewModel)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .navigationTitle("Todo list")
        .task {
            await viewModel.observeTodoItems()
        }
        .sheet(isPresented: $addTodoItemSheetPresented) {
            CreateTodoItemView(completion: createTodoItem)
        }
    }

    private func addItem() {
        addTodoItemSheetPresented = true
    }

    @MainActor private func createTodoItem(_ request: CreateTodoItemRequest) {
        addTodoItemSheetPresented = false
        viewModel.createTodoItem(request)
    }
}

private struct TodoListContentView: View {
    @Binding var viewModel: TodoListViewModel

    var body: some View {
        if viewModel.items.isEmpty {
            Text("Create a new to-do item by tapping the + button!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        TodoItemView(item: item)
                    } label: {
                        TodoItemCell(item: item)
                    }
                }
                .onDelete(perform: deleteItems)
            }
        }
    }

    @MainActor private func deleteItems(offsets: IndexSet) {
        withAnimation {
            let items = offsets.map { index in
                viewModel.items[index]
            }
            viewModel.deleteTodoItemBatch(items)
        }
    }
}

private struct TodoItemCell: View {
    var item: TodoItem

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.text)
                .font(.body)
                .foregroundStyle(.primary)
            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    TodoListView(viewModel: TodoListViewModel())
}
