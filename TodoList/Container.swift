//
//  Container.swift
//  TodoList
//
//  Copyright © 2024 Q42. All rights reserved.
//

import Foundation
import Factory

extension Container {

    // MARK: Todos

    var todoItemRepository: Factory<TodoItemRepository> {
        Factory(self) { TodoItemRepository(todoLocalDataSource: self.todoItemLocalDataSource()) }
    }

    var todoItemLocalDataSource: Factory<TodoItemLocalDataSource> {
        Factory(self) { TodoItemLocalDataSource(inMemory: false) }.singleton
    }

    // MARK: User

    var userRepository: Factory<UserRepositoryProtocol> {
        Factory(self) { UserRepository() }
    }

    var userRemoteDataSource: Factory<UserRemoteDataSource> {
        Factory(self) { UserRemoteDataSource() }
    }

    var userLocalDataSource: Factory<UserLocalDataSource> {
        Factory(self) { UserLocalDataSource() }
    }
}
