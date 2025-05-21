//
//  ContentView.swift
//  timer_app
//
//  Created by 高橋直斗 on 2025/05/21.
//

import SwiftUI

struct ContentView: View {
    @State private var timerRemaining = 10
    @State private var timer: Timer? = nil
    @State private var isRunning = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("タイマーアプリ")
                .font(.largeTitle)
            
            Text("\(timerRemaining)秒")
                .font(.system(size:48))
                .monospacedDigit()
            
            HStack(spacing: 20) {
                Button("スタート") {
                    startTimer()
                }
                .disabled(isRunning)
                .buttonStyle(.borderedProminent)
                
                Button("ストップ") {
                    stopTimer()
                }
                .disabled(!isRunning)
                .buttonStyle(.bordered)
                
                Button("リセット") {
                    resetTimer()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
    
    func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timerRemaining > 0 {
                timerRemaining -= 1
            } else {
                stopTimer()
            }
        }
    }
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        timerRemaining = 10
    }
}
    

#Preview {
    ContentView()
}
