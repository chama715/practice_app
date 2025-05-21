//
//  ContentView.swift
//  meigen_app
//
//  Created by 高橋直斗 on 2025/05/21.
//

import SwiftUI

struct ContentView: View {
    @State private var newQuote = ""
    @State private var quotes: [String] = []
    
    var body: some View {
        VStack(spacing: 16) {
            Text("名言メーカー")
                .font(.largeTitle)
            
            TextField("名言を入力", text: $newQuote)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("追加") {
                if !newQuote.isEmpty {
                    quotes.append(newQuote)
                    newQuote = ""
                }
                }
            .buttonStyle(.borderedProminent)
            
            List {
                ForEach(quotes, id: \.self) { quote in
                    Text("・\(quote)")
                }
                .onDelete { indexSet in
                    quotes.remove(atOffsets: indexSet)
                }
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
