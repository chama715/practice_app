//
//  ContentView.swift
//  ShoppingList_app
//
//  Created by 高橋直斗 on 2025/05/18.
//

import SwiftUI

struct Item: Identifiable {//まずはItem構造体を作る。
    let id = UUID()
    let name: String
    let quantity: String//LIstで使うためのidを定義。あとは商品名と個数を定義。Identifiableってのは、idを使う時に使うプロトコル
}

struct ContentView: View {//メイン画面の定義
    @State private var itemName = ""
    @State private var itemQuantity = ""
    @State private var items: [Item] = []//3つの状態変数。商品名入力欄の空のやつ、個数入力欄の空のやつ。追加されたItemの配列
   
    var body: some View {
        VStack(spacing: 16) {
            Text("買い物リスト")
                .font(.largeTitle)
            
            List {
                ForEach(items) { item in//Listの中身を1つずつ表示
                    Text("・\(item.name)（\(item.quantity)）")//item名、item個数を/をつけて表示
                }
                .onDelete { indexSet in
                    items.remove(atOffsets: indexSet)//消すやつ
                }
            }
            
            HStack {
                TextField("商品名",text: $itemName) //商品入力欄のテキストフィールダー。ここに入力された文字列は、itemNameに保存される。
                    .textFieldStyle(RoundedBorderTextFieldStyle())//$は、〜〜とつながっているよ！という意味
                
                TextField("個数",text: $itemQuantity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())//個数入力欄。itemQuantityに保存される

                Button("追加") {
                    if !itemName.isEmpty && !itemQuantity.isEmpty {//itemNameかつitemQuantityが空じゃなければ、処理が実行
                        let newItem = Item(name: itemName, quantity: itemQuantity)//newItemを作って、Itemsに追加される
                        items.append(newItem)//配列に新しい要素を追加するって意味
                        self.itemName = ""
                        self.itemQuantity = ""//商品入力欄と個数を空にする
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
