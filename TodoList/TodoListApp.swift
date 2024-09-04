//
//  TodoListApp.swift
//  TodoList
//
//  Copyright © 2024 Q42. All rights reserved.
//

import SwiftUI

@main
struct TodoListApp: App {
    @UIApplicationDelegateAdaptor var appDelegate: TodoListAppDelegate

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
