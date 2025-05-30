//
//  ContentView.swift
//  CatImage_app
//
//  Created by 高橋直斗 on 2025/05/30.
//

import SwiftUI

// モデル
struct CatImage: Codable {
    let url: String
}
//JSONデータを調べて、必要なプロパティ(今回は画像のurl)を定義する。
//Codebleというプロトコルをつけることで、JSONを変換することができる。

//ビュー
struct ContentView: View {
    @State private var imageURL: String = ""
    //表示する画像のURLを保存する状態変数。

    var body: some View {
        VStack(spacing: 20) {
            Text("ランダムにゃんこす🐈")
                .font(.largeTitle)
                .bold()

            if let url = URL(string: imageURL) {
                //imageURLが有効なURLなのかチェックする。オプショナルバインディング
                AsyncImage(url: url) { image in
                    //非同期で画像を読み込む標準ビュー。画像が来たらimageに入る。
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                } placeholder: {
                    ProgressView()
                    //画像が読み込まれる間にクルクルが表示。
                }
            } else {
                Text("画像を読み込み中...")
            }
            //画像URLが無効なときに表示される

            Button(action: {
                Task {
                    await searchCatImage()
                }
            }) {
                Text("にゃんこを取得")
                    .font(.title)
                    .padding()
            }
            //ボタンを押したら画像を取得するよっていうボタン。非同期処理でsearchImage()を呼び出す。
        }
        .padding()
        .onAppear {
            Task {
                await searchCatImage()
            }
            //アプリが起動したときに最初の猫を自動で読み込む
        }
    }

    //関数
    func searchCatImage() async {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search") else { return }
        //APIのURLを作成する、失敗したらreturnして中断。

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //API通信を実際に行うところ。try awaitは通信エラーの可能性があるよってこと？
            if let decoded = try? JSONDecoder().decode([CatImage].self, from: data),
               let first = decoded.first {
                //JSONを[CatImage]型の配列にデコード。最初の1件を取り出す。
                imageURL = first.url
                //取得したURLを代入。
            }
        } catch {
            print("エラー: \(error.localizedDescription)")
        }
        //通信エラーがあった時の処理
    }
}

#Preview {
    ContentView()
}

