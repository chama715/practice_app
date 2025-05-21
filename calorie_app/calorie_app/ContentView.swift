//
//  ContentView.swift
//  calorie_app
//
//  Created by 高橋直斗 on 2025/05/21.
//

import SwiftUI

struct FoodItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    var calorie: Int
}

struct ContentView: View {
    @State private var foodName = ""
    @State private var calorieText = ""
    @State private var foodItems: [FoodItem] = []
    
    var totalCalories: Int {
        foodItems.reduce(0) { $0 + $1.calorie }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("カロリー計算アプリ")
                .font(.largeTitle)
            
            HStack {
                TextField("食べ物", text: $foodName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("カロリー", text: $calorieText)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)
            
            Button("追加") {
                if let calories = Int(calorieText), !foodName.isEmpty {
                    let newItem = FoodItem(name: foodName, calorie: calories)
                    foodItems.append(newItem)
                    foodName = ""
                    calorieText = ""
                }
            }
            .buttonStyle(.borderedProminent)
            
            List(foodItems) {item in
                Text("・\(item.name) (\(item.calorie)kcal)")
            }
            Text("合計：\(totalCalories)kcal")
                .font(.headline)
                .padding(.top)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
