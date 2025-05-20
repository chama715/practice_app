//
//  ContentView.swift
//  ToDolist_app
//
//  Created by 高橋直斗 on 2025/05/17.
//

import SwiftUI

struct ContentView: View {
    @State private var newTask = ""
    @State private var tasks: [String] = []
    
    var body: some View {
        VStack(spacing: 16) {
            Text("📝ToDoリスト")
                .font(.largeTitle)
            
            List {
                ForEach(tasks, id: \.self) { task in
                    Text("・\(task)")
                }
            }
            
            HStack(spacing: 8) {
                TextField("やることを入力", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("追加") {
                    if !newTask.isEmpty {
                        tasks.append(newTask)
                        newTask = ""
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
