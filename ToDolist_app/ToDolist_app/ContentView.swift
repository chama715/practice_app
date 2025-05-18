//
//  ContentView.swift
//  ToDolist_app
//
//  Created by 高橋直斗 on 2025/05/17.
//

import SwiftUI

struct ContentView: View {
    @State private var newTask = ""
    //入力欄で記入する新しいタスクの一時的保管場所
    @State private var tasks: [String] = []
    //ToDoリストを入れておく配列
    
    var body: some View {
        VStack(spacing: 16) {
            Text("📝ToDoリスト")
                .font(.largeTitle)
            
            List {
                //縦に並べて表示するリスト
                ForEach(tasks, id: \.self) { task in
                Text("・\(task)")
                }
                //ForEachは配列をそれぞれ表示したい時に使う！
                //tasksの中の配列をそれぞれの文字列の名前のまま、・をつけて出力！
            }
            
            HStack(spacing: 8) {
                TextField("やることを入力", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("追加") {
                    if !newTask.isEmpty {
                        //空欄だったら無視
                        tasks.append(newTask)
                        //配列に追加。(入力した文字列を！)
                        newTask = ""
                        //入力欄を空に戻す
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
