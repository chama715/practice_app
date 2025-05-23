//
//  ContentView.swift
//  meigen_app
//
//  Created by 高橋直斗 on 2025/05/23.
//

import SwiftUI

//モデル。データの受け皿
struct Quote: Decodable {
    let content: String
    let author: String
}
//API通信を活用したアプリ開発をする場合、まずはこうしてデータの受け皿となる構造体を作る。
//名言アプリの場合、上記の2つのJSONデータが返ってくるからこうして作っておく。

//View。画面を表示するメインのところ。
struct ContentView: View {
    @State private var quote = ""
    @State private var author = ""
    //状態変数として、名言とその発した人の名前の空の変数を作っておく。
    
    var body: some View {
        VStack(spacing: 20) {
            Text("名言アプリ")
                .font(.largeTitle)
            
            Button("名言を取得") {
                fetchQuote()
            }
            .buttonStyle(.borderedProminent)
            //ボタンを押したら、fetchQuoteを呼び出す。
            
            if !quote.isEmpty {
                Text("\(quote)")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                //もし、quoteが空じゃなければ・・・quoteを表示。
                
                Text("by \(author)")
                    .font(.caption)
            }
            //同じく、quoteが空じゃなければ、authorをby付きで表示。
        }
        .padding()
    }
    //以下は関数。ボタンを押して名言を取得して表示する。
    func fetchQuote() {
        let url = URL(string: "https://api.quotable.io/random")!
        //このURLにアクセスすると、名言がもらえる
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            //通信スタート。URLSessionでネットにアクセスして、dataTask(with:url)で結果を受け取るタスクを作成。
            //通信がおわたら{}を処理
        guard let data = data else { return }
            //通信結果がちゃんと届いているかチェック。
            //dataには、APIから帰ってきたJSONデータが入る。
            //dataがnilだった場合、returnして終了。
            //guard let はアンラップ
            
            do {
                let result = try JSONDecoder().decode(Quote.self, from: data)
                //JSONをQuote構造体へ変換する。
                //tryは失敗するかもしればいから、失敗時はcatchに飛ぶよって意味。
                DispatchQueue.main.async {
                    quote = result.content
                    author = result.author
                }
                //変換した内容を画面に反映させる
            } catch {
                print("デコードエラー：", error)
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}

//API通信を活用したアプリ開発をする場合は、今回のようにモデル、ビュー、関数と3つの大きなまとまりができるって感じなのかな？
