//
//  ContentView.swift
//  Quiz_app
//
//  Created by 高橋直斗 on 2025/05/18.
//

import SwiftUI

struct Question {
    let text: String
    let choices: [String]
    let answerIndex: Int
}

struct ContentView: View {
    let questions = [
        Question(text: "よしおの猫種は？", choices: ["アメショ","ミヌエット","猫の見た目をしたおぢ"], answerIndex: 1),
        Question(text: "よしおの大好物は？", choices: ["ニンニク","うどん","生クリーム"], answerIndex: 2),
        Question(text: "よしおのパパの名前は？", choices: ["ハリー","トラオ","タロウ"], answerIndex: 0)
    ]
    
    @State private var currentIndex = 0
    @State private var isAnswerd = false
    @State private var isCorrect = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("よしおクイズ🐈〜初級編〜")
                .font(.largeTitle)
            
            Text(questions[currentIndex].text)
                .font(.headline)
            
            ForEach(0..<questions[currentIndex].choices.count, id: \.self) { i in
                Button(questions[currentIndex].choices[i]) {
                    if !isAnswerd {
                        isAnswerd = true
                        isCorrect = i == questions[currentIndex].answerIndex
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(isAnswerd)//1度押したら押せなくさせる
            }
            if isAnswerd {
                Text(isCorrect ? "🙆正解！" : "🙅不正解")
                    .font(.title2)
                    .foregroundColor(isCorrect ? .green : .red)
                
                Button("次の問題へ") {
                    if currentIndex < questions.count - 1 {
                        currentIndex += 1
                        isAnswerd = false
                        isCorrect = false
                    }
                }
                .padding(.top)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
