//
//  TodoItemRepository.swift
//  TodoList
//
//  Created by Mathijs Bernson on 04/09/2024.
//  Copyright © 2024 Q42. All rights reserved.
//

import Foundation
import Factory

class TodoItemRepository {
    private let todoLocalDataSource: TodoItemLocalDataSource

    init(todoLocalDataSource: TodoItemLocalDataSource) {
        self.todoLocalDataSource = todoLocalDataSource
    }

    func getAllTodoItems() throws -> [TodoItem] {
        let todoItems = try todoLocalDataSource.getAllTodoItems()
        return todoItems
    }

    func observeTodoItems() -> AsyncStream<[TodoItem]> {
        todoLocalDataSource.observeTodoItems()
    }

    @MainActor func createTodoItem(_ todoItem: TodoItem) {
        todoLocalDataSource.createTodoItem(todoItem)
    }

    @MainActor func deleteTodoItemBatch(_ todoItems: [TodoItem]) {
        todoLocalDataSource.deleteTodoItemBatch(todoItems)
    }
}
