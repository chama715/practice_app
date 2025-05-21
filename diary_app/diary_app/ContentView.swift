//
//  ContentView.swift
//  diary_app
//
//  Created by 高橋直斗 on 2025/05/21.
//

import SwiftUI

struct DiaryEntry: Identifiable {
    let id = UUID()
    let date: Date
    let text: String
}

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var diaryText = ""
    @State private var diaryEntries: [DiaryEntry] = []
    
    var body: some View {
        VStack(spacing: 16) {
            Text("🐈よしお日記🐈")
                .font(.largeTitle)
            
            DatePicker("日付を選択", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding(.horizontal)
            
            TextEditor(text: $diaryText)
                .frame(height: 150)
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                .padding(.horizontal)
            
            Button("保存🐾") {
                let newEntry = DiaryEntry(date: selectedDate, text: diaryText)
                diaryEntries.append(newEntry)
                diaryText = ""
            }
            .buttonStyle(.borderedProminent)
            
            List(diaryEntries) { entry in
                VStack(alignment: .leading) {
                    Text(dateToString(entry.date))
                        .font(.headline)
                    Text(entry.text)
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
        }
        .padding()
    }
    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
