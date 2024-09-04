//
//  TodoItemLocalDataSource.swift
//  TodoList
//
//  Created by Mathijs Bernson on 04/09/2024.
//  Copyright © 2024 Q42. All rights reserved.
//

import Foundation
import SwiftData

class TodoItemLocalDataSource {
    private let modelContainer: ModelContainer
    private let backgroundContext: ModelContext

    init(inMemory: Bool) {
        let schema = Schema([
            TodoItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            backgroundContext = ModelContext(modelContainer)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    func getAllTodoItems() throws -> [TodoItem] {
        let query = FetchDescriptor<TodoItem>()
        let todoItems = try backgroundContext.fetch(query)
        return todoItems
    }

    func observeTodoItems() -> AsyncStream<[TodoItem]> {
        observeModels(sort: \.timestamp)
    }

    @MainActor func createTodoItem(_ todoItem: TodoItem) {
        modelContainer.mainContext.insert(todoItem)
    }

    @MainActor func deleteTodoItemBatch(_ todoItems: [TodoItem]) {
        for item in todoItems {
            backgroundContext.delete(item)
        }
    }

    // MARK: Internal

    private func observeModels<Model: PersistentModel>(
        filter: Predicate<Model>? = nil,
        sort keyPath: KeyPath<Model, some Comparable>,
        order: SortOrder = .forward
    ) -> AsyncStream<[Model]> {
        let fetchDescriptor = FetchDescriptor(
            predicate: filter,
            sortBy: [SortDescriptor(keyPath, order: order)]
        )
        return observeModels(matching: fetchDescriptor)
    }

    private func observeModels<Model: PersistentModel>(
        matching fetchDescriptor: FetchDescriptor<Model>
    ) -> AsyncStream<[Model]> {
        AsyncStream { continuation in
            let task = Task {
                for await _ in NotificationCenter.default.notifications(
                    named: .NSPersistentStoreRemoteChange
                ).map({ _ in () }) {
                    do {
                        let models = try backgroundContext.fetch(fetchDescriptor)
                        continuation.yield(models)
                    } catch {
                        // log/ignore the error, or return an AsyncThrowingStream
                    }
                }
            }
            continuation.onTermination = { _ in
                task.cancel()
            }
            do {
                let models = try backgroundContext.fetch(fetchDescriptor)
                continuation.yield(models)
            } catch {
                // log/ignore the error, or return an AsyncThrowingStream
            }
        }
    }

}
