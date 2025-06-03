//
//  CatImage.swift
//  CatImage2_app
//
//  Created by 高橋直斗 on 2025/06/01.
//

import Foundation

// 今回はシンプル。受け皿なのでCodableをつける。プロパティは1つでOK
struct CatImage: Codable {
    let url: String
}
