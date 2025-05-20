//
//  ContentView.swift
//  omikuji_app
//
//  Created by 高橋直斗 on 2025/05/16.
//

import SwiftUI

struct ContentView: View {
    @State private var result = "運勢をひこう！"
    
    let fortunes = ["大吉🤩","中吉😁","小吉😉","吉😏","凶😑","大凶😭","⭐️🐈スーパーミラクルにゃんこす🐈⭐️"]
    
    var body: some View {
        VStack(spacing: 32) {
            Text("今日の運勢は・・・")
                .font(.title)
            
            Text(result)
                .font(.largeTitle)
            
            Button("ひく") {
                result = fortunes.randomElement() ?? "？"
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
