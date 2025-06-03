//
//  ExchangeViewModel.swift
//  kawase2_app
//
//  Created by 高橋直斗 on 2025/06/02.
//

import Foundation

// UIの更新をメインスレッドで行うためのおまじない。
@MainActor
// このViewModelをViewと連携させるためのクラス。
class ExchangeViewModel: ObservableObject {
    // API通信の結果を入れておく状態と、エラー時用の空箱。
    @Published var rateText: String = ""
    @Published var errorMessage: String?
    
    func fetchRate() async {
        // APIのURLはこれだよ。
        let urlString = "https://api.exchangerate.host/latest?base=USD&symbols=JPY"
        // このURLが有効か有効でないかのチェック。有効でない場合は実行しないでエラーメッセージを表示。
        guard let url = URL(string: urlString) else {
            errorMessage = "URL作成失敗"
            return
        }
        
        //　ここから通信が始まる。
        do {
            // ジェネリック関数を使い、JSONデータをSwiftの構造体に変換。
            let result: ExchangeRateResponse = try await fetch(url: url)
            // もし、JPYのレートを取り出せたら・・・
            if let jpy = result.rates["JPY"] {
                // 表示用テキストに変換して反映させる。
                rateText = "1 \(result.base) = \(jpy) JPY"
                // JPYがなければエラーメッセージを表示。
            } else {
                errorMessage = "JPYのレートが見つかりません"
            }
            // 通信失敗時はこのメッセージを表示。
        } catch {
            errorMessage = "読み込みに失敗しました: \(error.localizedDescription)"
        }
    }
    
    // 汎用的に使える非同期の通信、デコード関数。
    private func fetch<T: Decodable>(url: URL) async throws -> T {
        // APIにアクセスしてデータを取得する。
        let (data, _) = try await URLSession.shared.data(from: url)
        // 取得したJSONデータをデコードして返す。
        return try JSONDecoder().decode(T.self, from: data)
    }
}
