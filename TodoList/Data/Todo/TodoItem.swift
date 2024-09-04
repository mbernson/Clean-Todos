//
//  TodoItem.swift
//  TodoList
//
//  Created by Mathijs Bernson on 04/09/2024.
//  Copyright © 2024 Q42. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class TodoItem {
    var text: String
    var timestamp: Date

    init(text: String, timestamp: Date) {
        self.text = text
        self.timestamp = timestamp
    }

    static let example = TodoItem(text: "Water the plants", timestamp: Date(timeIntervalSince1970: 1725447584))
}
