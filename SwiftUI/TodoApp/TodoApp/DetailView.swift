//
//  DetailView.swift
//  TodoApp
//
//  Created by Alp Ceylan on 2.11.2020.
//

import SwiftUI

struct DetailView: View {
    var todo: Todo
        
    @State var title: String
    @State var description: String
    
    @State var isChanged = false
    
    func validate() {
        if title != todo.title || description != todo.title {
            isChanged = true
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("Title")
                            .font(.system(size: 16))
                        TextField("", text: $title, onEditingChanged: onChange(of: title, perform: { value in
                            self.validate()
                        }) as! (Bool) -> Void)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding(.bottom, 8)
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.system(size: 16))
                        TextField("", text: $description)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button(action: {}, label: {
                            Text("Save")
                                .foregroundColor(.blue)
                        }).disabled(isChanged)
                        Spacer()
                    }
                }
            }.navigationTitle(todo.title)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let todo = Todo(title: "alp", description: "deneme")
        
        DetailView(todo: todo, title: todo.title, description: todo.description)
    }
}
