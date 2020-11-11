//
//  ContentView.swift
//  TodoApp
//
//  Created by Alp Ceylan on 2.11.2020.
//

import SwiftUI

struct ContentView: View {
    let todoStore = TodoStore()
    
    var body: some View {
        List(todoStore.todos, id: \.self) { todo in
            Text(todo.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
