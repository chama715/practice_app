//
//  ContentView.swift
//  CatImage2_app
//
//  Created by 高橋直斗 on 2025/06/01.
//

import SwiftUI

struct ContentView: View {
    // CatViewModelを画面で使うための宣言。ViewがこのViewModelを監視するよという意味。
    // @StateObjectは、画面でViewModelを管理、生成するときに使う。(別ファイルに作ってるから、それをここの画面で使うための手続き的な？)
    @StateObject private var viewModel = CatViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("にゃんこ画像メーカー🐈")
                .font(.largeTitle)
                .bold()
            
            // 画像のURLからURL型に変換できるかのチェック
            if let url = URL(string: viewModel.imageURL) {
                // 非同期で画像を読み込む。
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                    // 画像が読み込まれている間、くるくるインジケーターを表示
                } placeholder: {
                    ProgressView()
                }
            } else {
                Text("画像を読み込み中")
            }
            // ボタンを押すと次の画像を取得する。
            // Task {await}は非同期関数を安全に実行するときのやつ。fetchCatImage()で関数を呼び出す。
            Button("次のにゃんこ画像") {
                Task {
                    await viewModel.fetchCatImage()
                }
            }
            .padding()
        }
        .padding()
        
        // アプリ起動時に、とりあえず1枚読み込む。
        .onAppear() {
            Task {
                await viewModel.fetchCatImage()
            }
        }
    }
}

#Preview {
    ContentView()
}
