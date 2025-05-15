//
//  ContentView.swift
//  dice_app
//
//  Created by 高橋直斗 on 2025/05/15.
//

import SwiftUI
//UIを作るためのおまじない

struct ContentView: View {
    //画面の定義。
    @State private var diceNumber = 1
    //サイコロの目を決める状態変数。初期値は1にしておく。
    
    var body: some View {
        VStack(spacing: 32) {
            //spacingとかpaddingの使い分けができない
            Text("🐈サイコロアプリ🐈")
                .font(.title)
                .padding()
            //題名的なもの。もっと上に配置してもいいんだけどな
            
            Image("dice\(diceNumber)")
                            .resizable()
                            .frame(width: 150, height: 150)
            
            Button("サイコロをふる!!") {
                diceNumber = Int.random(in: 1...6)
            }
            .buttonStyle(.borderedProminent)
            //ボタンを押すとサイコロをふる。1~6の中からランダムで数字が出て、diceNumberとしてTextに表示される。
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
