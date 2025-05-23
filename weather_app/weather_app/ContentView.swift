//
//  ContentView.swift
//  weather_app
//
//  Created by 高橋直斗 on 2025/05/22.
//

import SwiftUI

struct WeatherResponse: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}
//構造体。モデル。データの受け皿。API通信を活用して、送られてきたJSONデータを受け取る構造体。
//Decodableというプロトコルが目印となる。
//都市名、気温、天気の配列を受け取る。

struct Main: Decodable {
    let temp: Double
}
//Mainの中のtempを受け取る構造体。

struct Weather: Decodable {
    let description: String
}
//weatherの配列の中のdescriptionを受け取る構造体。

//ここまでで事前準備はOK？
//これは裏方の仕事であって、画面に表示するようなものではないから、ContentViewからは仲間はずれなのかな？

struct ContentView: View {
    @State private var city = ""
    @State private var weatherDescription = ""
    @State private var temperature: Double? = nil
    //都市名の状態変数（いろんな都市を入力するから、空の状態変数を作っておく）
    //天気の状態変数（場所によって天気は変わるから、これも空の状態を作っておく）
    //気温の状態変数（小数になるだろうからDouble型、nilの時は表示しない。？？気温でnilとかある？）

    var body: some View {
        VStack(spacing: 20) {
            Text("🌦 天気アプリ")
                .font(.largeTitle)

            TextField("都市名を入力", text: $city)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            //調べたい都市を入力する。状態変数のcityとバインディングしている。

            Button("天気を取得") {
                fetchWeather(for: city) { result in
                    if let result = result {
                        weatherDescription = result.weather.first?.description ?? "不明"
                        temperature = result.main.temp
                    } else {//以下はエラーだった時の処理
                        weatherDescription = "取得失敗"
                        temperature = nil
                    }
                }
            }
            .buttonStyle(.borderedProminent)

            if !weatherDescription.isEmpty {
                Text("天気：\(weatherDescription)")
            }
            //天気の情報が空じゃなければ、表示する。

            if let temp = temperature {
                Text("気温：\(String(format: "%.1f", temp)) ℃")
            }
            //気温を表示。
        }
        .padding()
    }
}

func fetchWeather(for city: String, completion: @escaping (WeatherResponse?) -> Void) {
    let apiKey = "ae72e79b4c55bc11a79aa268f87fb0ec"//apiキー
    let cityQuery = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city//
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityQuery)&appid=\(apiKey)&units=metric&lang=ja"//

    guard let url = URL(string: urlString) else {
        completion(nil)
        return
    }
    //URLが正しく作られなければ、終了する。

    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else {
            completion(nil)
            return
        }
        //

        do {
            let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
            DispatchQueue.main.async {
                completion(decodedData)
            }
        } catch {
            print("デコード失敗：", error)
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }.resume()
}

#Preview {
    ContentView()
}
