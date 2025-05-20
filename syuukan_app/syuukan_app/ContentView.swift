//
//  ContentView.swift
//  syuukan_app
//
//  Created by 高橋直斗 on 2025/05/17.
//

import SwiftUI

struct ContentView: View {
    let days = ["月","火","水","木","金","土","日"]
    @State private var habits = Array(repeating: false, count: 7)
    
    var body: some View {
        VStack(spacing: 16) {
            Text("習慣トラッカー")
                .font(.title)
            
            ForEach(0..<days.count, id: \.self) { index in
                HStack {
                    Text("[ \(days[index]) ]")
                    Spacer()
                    Text(habits[index] ? "☑️" : "❌")
                        .onTapGesture {
                            habits[index].toggle()
                        }
                }
                .padding(.horizontal)
            }
            Button("リセット") {
                habits = Array(repeating: false, count: 7)
            }
            .padding(.top, 16)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
