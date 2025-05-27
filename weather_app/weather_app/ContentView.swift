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

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}

struct ContentView: View {
    @State private var city = ""
    @State private var weatherDescription = ""
    @State private var temperature: Double? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("🌦 天気アプリ")
                .font(.largeTitle)

            TextField("都市名を入力", text: $city)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("天気を取得") {
                fetchWeather(for: city) { result in
                    if let result = result {
                        weatherDescription = result.weather.first?.description ?? "不明"
                        temperature = result.main.temp
                    } else {
                        weatherDescription = "取得失敗"
                        temperature = nil
                    }
                }
            }
            .buttonStyle(.borderedProminent)

            if !weatherDescription.isEmpty {
                Text("天気：\(weatherDescription)")
            }

            if let temp = temperature {
                Text("気温：\(String(format: "%.1f", temp)) ℃")
            }
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
