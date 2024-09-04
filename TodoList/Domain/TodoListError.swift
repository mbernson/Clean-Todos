//
//  TodoListError.swift
//  TodoList
//
//  Copyright © 2024 Q42. All rights reserved.
//

import Foundation

struct TodoListError: Error {
    let message: String
}

extension TodoListError: LocalizedError {
    var errorDescription: String? { message }
}
