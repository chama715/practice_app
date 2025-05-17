//
//  ContentView.swift
//  syuukan_app
//
//  Created by 高橋直斗 on 2025/05/17.
//

import SwiftUI

struct ContentView: View {
    let days = ["月","火","水","木","金","土","日"]
    //定数days。曜日を入れた配列
    @State private var habits = Array(repeating: false, count: 7)
    //状態変数habits。7つのfalseが入った配列。
    
    var body: some View {
        VStack(spacing: 16) {
            //全体は縦方式みたいなノリ
            Text("習慣トラッカー")
                .font(.title)
            //シンプルにタイトル
            
            ForEach(0..<days.count, id: \.self) { index in
                HStack {
                    //曜日と❌を横に並べる
                    Text("[ \(days[index]) ]")
                    //daysをインデックス番号で呼ぶ。
                    Spacer()
                    Text(habits[index] ? "☑️" : "❌")
                    //habitをインデックス番号で呼ぶ。
                        .onTapGesture {
                            habits[index].toggle()
                        }
                    //タップしたら条件を自動で反転。falseがtrueになる。逆も。
                }
                .padding(.horizontal)
            }
            Button("リセット") {
                habits = Array(repeating: false, count: 7)
            }
            //リセットというボタンをタップすると、habitsが7つのfalseになる。つまりリセット。
            .padding(.top, 16)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
