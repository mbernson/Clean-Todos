//
//  CreateTodoItemUseCase.swift
//  TodoList
//
//  Created by Mathijs Bernson on 04/09/2024.
//  Copyright © 2024 Q42. All rights reserved.
//

import Foundation
import Factory

struct CreateTodoItemRequest {
    let text: String
    let timestamp: Date
}

class CreateTodoItemUseCase {
    @Injected(\.todoItemRepository) private var todoItemRepository

    @MainActor func invoke(request: CreateTodoItemRequest) {
        let todoItem = TodoItem(text: request.text, timestamp: request.timestamp)
        todoItemRepository.createTodoItem(todoItem)
    }
}

class GetTodoItemsUseCase {
    @Injected(\.todoItemRepository) private var todoItemRepository

    func invoke() throws -> [TodoItem] {
        try todoItemRepository.getAllTodoItems()
    }
}

class DeleteTodoItemBatchUseCase {
    @Injected(\.todoItemRepository) private var todoItemRepository

    @MainActor func invoke(todoItems: [TodoItem]) {
        todoItemRepository.deleteTodoItemBatch(todoItems)
    }
}

class ObserveTodoItemsUseCase {
    @Injected(\.todoItemRepository) private var todoItemRepository

    func invoke() -> AsyncStream<[TodoItem]> {
        todoItemRepository.observeTodoItems()
    }
}
