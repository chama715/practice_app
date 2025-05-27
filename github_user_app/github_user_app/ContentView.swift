//
//  ContentView.swift
//  github_user_app
//
//  Created by 高橋直斗 on 2025/05/23.
//

import SwiftUI

struct GitHubUser: Decodable {
    let login: String
    let name: String?
    let location: String?
    let followers: Int
}

struct ContentView: View {
    @State private var username = ""
    @State private var name = ""
    @State private var location = ""
    @State private var followers: Int? = nil
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing:20) {
            Text("GitHubユーザー検索")
                .font(.largeTitle)
            
            TextField("ユーザー名を入力", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button("検索") {
                fetchGitHubUser(for: username)
            }
            .buttonStyle(.borderedProminent)
            
            if !name.isEmpty {
                Text("名前：\(name)")
                Text("場所：\(location)")
                
                if let f = followers {
                    Text("フォロワー：\(f)")
                }
                
            } else if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
    
    func fetchGitHubUser(for username: String) {
        let urlString = "https://api.github.com/users/\(username)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let user = try JSONDecoder().decode(GitHubUser.self, from: data)
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
        }.resume()
    }
}


#Preview {
    ContentView()
}
