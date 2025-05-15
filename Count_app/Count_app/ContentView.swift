//
//  ContentView.swift
//  Count_app
//
//  Created by 高橋直斗 on 2025/05/15.
//

import SwiftUI
//SwiftUIの機能を使うために必要なライブラリ。個人的な感覚として、ContentViewの時はこれを使っているイメージ

struct ContentView: View {
    //画面の定義。メインビューを作っている。
    @State private var count = 0
    //状態変数countを定義。初期値を0にする。
    
    var body: some View {
        //以下で画面の中身を作っていく
        
        VStack(spacing: 32) {
            //部品を縦に並べる
            Text("カウントアプリ")
                .font(.title)
            //シンプルに文字の出力
            Text("現在の数:\(count)")
                .font(.title)
            //現在の数を表す。\()で数値を文字列に入れ込む。
            
            HStack(spacing: 24) {
                //部品を横に並べる。
                Button("+1") {
                    count += 1
                }
                .buttonStyle(.borderedProminent)
                //押すとcountに+1されるボタン
                
                Button("-1") {
                    count -= 1
                }
                .buttonStyle(.bordered)
                //押すとcountに-1されるボタン
            }
            Button("リセット") {
                count = 0
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
