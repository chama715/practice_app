//
//  ContentView.swift
//  ShoppingList_app
//
//  Created by 高橋直斗 on 2025/05/18.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let quantity: String
}

struct ContentView: View {
    @State private var itemName = ""
    @State private var itemQuantity = ""
    @State private var items: [Item] = []
    
    var body: some View {
        VStack(spacing: 16) {
            Text("買い物リスト")
                .font(.largeTitle)
            
            List {
                ForEach(items) { item in
                    Text("・\(item.name)（\(item.quantity)）")
                }
                .onDelete { indexSet in
                    items.remove(atOffsets: indexSet)
                }
            }
            
            HStack {
                TextField("商品名",text: $itemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("個数",text: $itemQuantity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("追加") {
                    if !itemName.isEmpty && !itemQuantity.isEmpty {
                        let newItem = Item(name: itemName, quantity: itemQuantity)
                        items.append(newItem)
                        self.itemName = ""
                        self.itemQuantity = ""
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
