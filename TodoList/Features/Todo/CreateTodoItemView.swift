//
//  CreateTodoItemView.swift
//  TodoList
//
//  Created by Mathijs Bernson on 04/09/2024.
//  Copyright © 2024 Q42. All rights reserved.
//

import SwiftUI

struct CreateTodoItemView: View {
    @State var text: String = ""
    @FocusState var isTextEditorFocused: Bool
    let completion: (CreateTodoItemRequest) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextEditor(text: $text)
                        .focused($isTextEditorFocused)
                }
            }
            .navigationTitle("New todo item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Done") {
                        let request = CreateTodoItemRequest(text: text, timestamp: Date.now)
                        completion(request)
                    }
                }
            }
            .onAppear {
                isTextEditorFocused = true
            }
        }
    }
}

#Preview {
    CreateTodoItemView { request in
        print(request)
    }
}
