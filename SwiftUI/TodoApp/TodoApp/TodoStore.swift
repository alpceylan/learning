//
//  TodoStore.swift
//  TodoApp
//
//  Created by Alp Ceylan on 2.11.2020.
//

import Foundation

class TodoStore: ObservableObject {
    @Published var todos = [
        Todo(title: "Alp", description: "Ceylan"),
        Todo(title: "Kaan", description: "Ceylan")
    ]
    
    func addTodo(newTodo: Todo) {
        todos.append(newTodo)
    }
}

struct Todo: Identifiable, Hashable {
    var id = UUID()
    
    var title: String
    var description: String
    var date = Date()
}
