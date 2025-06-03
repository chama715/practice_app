//
//  CatViewModel.swift
//  CatImage2_app
//
//  Created by 高橋直斗 on 2025/06/01.
//

import Foundation

// UI関連の処理をメインスレッドで行う宣言。つまりViewModelとかでしか出てこない？？
@MainActor
// Viewにデータを送れるクラス
class CatViewModel: ObservableObject {
    // Viewにここの値が変わったよと通知するプロパティ
    @Published var imageURL: String = ""
    // エラーメッセージをViewに伝えるための変数
    @Published var errorMessage: String?
    
    // 非同期で処理される関数
    func fetchCatImage() async {
        // 画像を取得するためのAPIのURL
        let urlString = "https://api.thecatapi.com/v1/images/search"
        // URLが作られなかった場合は処理を中断！の意味を持つ式
        guard let url = URL(string: urlString) else {
            errorMessage = "URLが不正です"
            return
        }
        
        // fetch(url)を呼んで、API通信を行う。結果を「[CatImageの配列として受け取る]
        do {
            let result: [CatImage] = try await fetch(url)
            // 画像が1枚きたら、最初の1件のURLを使うよ。
            if let first = result.first {
                imageURL = first.url
            }
            // 通信に失敗したらこのメッセージを表示するよ。
        } catch {
            errorMessage = "通信に失敗しました: \(error.localizedDescription)"
        }
    }
    // 汎用のAPI通信関数。どんな構造体でも使いまわせるようにジェネリクスを使っている。
    private func fetch<T: Decodable>(_ url: URL) async throws -> T {
        // 実際に通信してデータを受け取る。
        let (data, _) = try await URLSession.shared.data(from: url)
        // 受け取ったデータを指定した型でデコードして返す。
        return try JSONDecoder().decode(T.self, from: data)
    }
}
