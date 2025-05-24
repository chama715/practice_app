//
//  ContentView.swift
//  github_user_app
//
//  Created by 高橋直斗 on 2025/05/23.
//

import SwiftUI

//モデル
struct GitHubUser: Decodable {
    let login: String
    let name: String?
    let location: String?
    let followers: Int
}
//APIから返ってくるJSONを受け取るための構造体。loginとか、nameとかがくるからそれを用意しておく。
//name,locationはない場合もあるから、オプショナル型。

//View
struct ContentView: View {
    @State private var username = ""//入力されたユーザーネームを保管
    @State private var name = ""
    @State private var location = ""
    @State private var followers: Int? = nil
    @State private var errorMessage = ""
    //APIから所得した結果を入れておく状態変数。

    var body: some View {
        VStack(spacing:20) {
            Text("GitHubユーザー検索")
                .font(.largeTitle)
            
            TextField("ユーザー名を入力", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            //ユーザーネームを入力するところ。上のusernameとバインディングしている。
            
            Button("検索") {
                fetchGitHubUser(for: username)
            }
            .buttonStyle(.borderedProminent)
            //ボタンを押したら、fetchGitHubUserを呼び出す。
            
            if !name.isEmpty {
                Text("名前：\(name)")
                Text("場所：\(location)")
                //nameが空じゃなければ、名前と場所を表示。
                if let f = followers {
                    Text("フォロワー：\(f)")
                }
                //フォロワーも表示。
            } else if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            //名前が空で、エラーメッセージがある時は赤文字で表示。
        }
        .padding()
    }
    
    //関数
    func fetchGitHubUser(for username: String) {
        //通信処理をスタート！Buttonが押されたらスタート。
        let urlString = "https://api.github.com/users/\(username)"
        guard let url = URL(string: urlString) else { return }
        //入力されたユーザー名をURLをURLに埋め込み、アクセス先を作成。
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            //ネットにアクセスして、通信開始。結果が返ってきたら、この中の処理を実行する。
            guard let data = data else { return }
            //通信が失敗した時は処理を終える。
            
            do {
                let user = try JSONDecoder().decode(GitHubUser.self, from: data)
                //JSONのデータをSWiftのGitHub構造体に変換。
                DispatchQueue.main.async {
                    name = user.name ?? "不明"
                    location = user.location ?? "不明"
                    followers = user.followers
                    errorMessage = ""
                }
                //
            } catch {
                DispatchQueue.main.async {
                    name = ""
                    location = ""
                    followers = nil
                    errorMessage = "ユーザーが見つかりませんでした"
                }
            }
            //デコードに失敗した時は、エラーメッセージを表示する。
        }.resume()
        //通信処理を実行するおまじない。これがないとはじまらない。
    }
}


#Preview {
    ContentView()
}
