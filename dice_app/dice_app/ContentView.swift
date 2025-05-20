//
//  ContentView.swift
//  dice_app
//
//  Created by 高橋直斗 on 2025/05/15.
//

import SwiftUI

struct ContentView: View {
    @State private var diceNumber = 1
    var body: some View {
        VStack(spacing: 32) {
            Text("🐈サイコロアプリ🐈")
                .font(.title)
                .padding()
            
            Image("dice\(diceNumber)")
                            .resizable()
                            .frame(width: 150, height: 150)
            
            Button("サイコロをふる!!") {
                diceNumber = Int.random(in: 1...6)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
