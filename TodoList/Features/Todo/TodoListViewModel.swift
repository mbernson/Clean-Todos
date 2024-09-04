//
//  TodoListViewModel.swift
//  TodoList
//
//  Created by Mathijs Bernson on 04/09/2024.
//  Copyright © 2024 Q42. All rights reserved.
//

import Foundation
import Observation

@Observable final class TodoListViewModel {
    var items: [TodoItem]

    init() {
        items = []
    }

    @MainActor func createTodoItem(_ request: CreateTodoItemRequest) {
        let createTodoItem = CreateTodoItemUseCase()
        createTodoItem.invoke(request: request)
    }

    func observeTodoItems() async {
        let observeTodoItems = ObserveTodoItemsUseCase()
        for await todoItems in observeTodoItems.invoke() {
            self.items = todoItems
        }
    }

    func refreshTodoItems() async {
        do {
            let getTodoItems = GetTodoItemsUseCase()
            items = try getTodoItems.invoke()
        } catch {
            print(error)
        }
    }

    @MainActor func deleteTodoItemBatch(_ items: [TodoItem]) {
        let deleteItemBatch = DeleteTodoItemBatchUseCase()
        deleteItemBatch.invoke(todoItems: items)
    }
}
