//
//  ContentView.swift
//  kawase2_app
//
//  Created by 高橋直斗 on 2025/06/02.
//

import SwiftUI

struct ContentView: View {
    // ViewModelをこの画面で使うための宣言。
    @StateObject private var viewModel = ExchangeViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("為替アプリ")
                .font(.largeTitle)
                .bold()
            
            // APIで取得したレートの文字列を表示する。
            Text(viewModel.rateText)
                .font(.title)
            
            // エラーが出たときは赤文字で表示。
            if let error = viewModel.errorMessage {
                Text("⚠️ \(error)")
                    .foregroundColor(.red)
            }
            // ボタンを押すとAPI通信が行われる。
            Button("レートを取得") {
                Task {
                    await viewModel.fetchRate()
                                    }
                                }
                            }
                            .padding()
        
        // アプリ起動時にとりあえずの取得が行われる。
                            .onAppear {
                                Task {
                                    await viewModel.fetchRate()
                                }
                            }
                        }
                    }

#Preview {
    ContentView()
}
