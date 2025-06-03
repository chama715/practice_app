//
//  ExchangeRate.swift
//  kawase2_app
//
//  Created by 高橋直斗 on 2025/06/02.
//

import Foundation

struct ExchangeRateResponse: Codable {
    // JSONデータをチェックして、必要なプロパティをセット。ここが難しい。
    let base: String
    let date: String
    let rates: [String: Double]
}
