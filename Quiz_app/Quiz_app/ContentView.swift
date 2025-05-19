//
//  ContentView.swift
//  Quiz_app
//
//  Created by 高橋直斗 on 2025/05/18.
//

import SwiftUI//メイン画面を作る時はこれよな！

struct Question {//Question構造体を定義
    let text: String//問題文を入れる定数
    let choices: [String]//答えの選択肢を入れる定数
    let answerIndex: Int//答えの選択肢番号を入れる定数
}

struct ContentView: View {//アプリのメイン画面
    let questions = [
        Question(text: "よしおの猫種は？", choices: ["アメショ","ミヌエット","猫の見た目をしたおぢ"], answerIndex: 1),
        Question(text: "よしおの大好物は？", choices: ["ニンニク","うどん","生クリーム"], answerIndex: 2),
        Question(text: "よしおのパパの名前は？", choices: ["ハリー","トラオ","タロウ"], answerIndex: 0)
    ]//3つの問題の配列の定数を定義。questionが問題。Question(text: "", choices: [], answerIndex: )で1つの問題
    
    @State private var currentIndex = 0//今表示している問題は何問目か。の状態変数
    @State private var isAnswerd = false//回答済みかどうか
    @State private var isCorrect = false//正解かどうか
    
    var body: some View {
        VStack(spacing: 20) {
            Text("よしおクイズ🐈〜初級編〜")
                .font(.largeTitle)
            
            Text(questions[currentIndex].text)//今何問目か。
                .font(.headline)
            
            ForEach(0..<questions[currentIndex].choices.count, id: \.self) { i in//インデックスの数だけボタンを繰り返し表示。
                Button(questions[currentIndex].choices[i]) {
                    if !isAnswerd {
                        isAnswerd = true
                        isCorrect = i == questions[currentIndex].answerIndex//選択肢をボタンで表示。押されたら回答済みにする。
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(isAnswerd)//1度押したら押せなくさせる
            }
            if isAnswerd {//回答済みなら・・・
                Text(isCorrect ? "🙆正解！" : "🙅不正解")
                    .font(.title2)
                    .foregroundColor(isCorrect ? .green : .red)//結果を表示。正解か不正解か、緑か赤か。
                
                Button("次の問題へ") {
                    if currentIndex < questions.count - 1 {//問題数が残っていたら
                        currentIndex += 1//次の問題へ
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
