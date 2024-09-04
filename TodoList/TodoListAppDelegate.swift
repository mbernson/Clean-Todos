//
//  TodoListAppDelegate.swift
//  TodoList
//
//  Copyright © 2024 Q42. All rights reserved.
//

import UIKit
import Factory

class TodoListAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Additional app setup can be performed here.

        // Ensure SwiftData Container is loaded.
        let _ = Container.shared.todoItemLocalDataSource()

        return true
    }
}
