//
//  ContentView.swift
//  omikuji_app
//
//  Created by 高橋直斗 on 2025/05/16.
//

import SwiftUI
//UIを作るためのおまじない。ContentViewの時はこのイメージ。

struct ContentView: View {
    //この画面の定義をスタート
    @State private var result = "運勢をひこう！"
    //状態変数。とりあえずString型で文字が出力されている。
    
    let fortunes = ["大吉🤩","中吉😁","小吉😉","吉😏","凶😑","大凶😭","⭐️🐈スーパーミラクルにゃんこす🐈⭐️"]
    //定数fortunesに配列で運勢を入れておく
    
    var body: some View {
        VStack(spacing: 32) {
            Text("今日の運勢は・・・")
                .font(.title)
                //シンプルにテキストを表示
            
            Text(result)
                .font(.largeTitle)
            //運勢がここに表示される
            
            Button("ひく") {
                result = fortunes.randomElement() ?? "？"
            }
            .buttonStyle(.borderedProminent)
            //ボタンを押して、fortuneからランダムに1つ選んでresultに代入という処理。
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
