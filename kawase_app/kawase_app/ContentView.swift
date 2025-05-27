//
//  ContentView.swift
//  kawase_app
//
//  Created by 高橋直斗 on 2025/05/26.
//

import SwiftUI

struct ExchangeRateResponse: Decodable {
    let rates: [String: Double]
}

struct ContentView: View {
    @State private var rate: Double? = nil
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("為替レートアプリ")
                .font(.largeTitle)
            
            Button("レートを取得") {
                fetchRate()
            }
            .buttonStyle(.borderedProminent)

            
            if let rate = rate {
                Text("1ドル = \(String(format: "%.2f", rate))円")
                    .font(.title2)

            } else if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
    
    func fetchRate() {
        let urlString = "https://api.exchangerate-api.com/v4/latest/USD"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with:url) { data, response, error in
            guard let data = data else { return }
            
            do{
                let decoded = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                DispatchQueue.main.async {
                    rate = decoded.rates["JPY"]
                    errorMessage = ""
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "取得に失敗しました"
                }
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}
