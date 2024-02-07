//
//  SecondScreenView.swift
//  WeatherCast
//
//  Created by Mac on 06/02/2024.
//

import SwiftUI

struct WeatherCell: View {
    let time: String
    let weather: String
    let temperature: String

    var body: some View {
        HStack {
            Text(time)
                .font(.headline)
            Spacer()
            Text(weather)
                .font(.subheadline)
            Text(temperature)
                .font(.subheadline)
        }
        .padding()
    }
}

struct WeatherList: View {
    let weatherData: [WeatherModel]

    var body: some View {
        List(weatherData) { data in
            WeatherCell(time: data.time, weather: data.weather, temperature: data.temperature)
        }
        .navigationTitle("Hourly Forecast")
    }
}

struct WeatherModel: Identifiable {
    let id = UUID()
    let time: String
    let weather: String
    let temperature: String
}

struct WeatherList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherList(weatherData: generateWeatherData())
        }
    }

    static func generateWeatherData() -> [WeatherModel] {
        var weatherData: [WeatherModel] = []
        let currentDate = Date()

        for i in 0..<8 {
            let time = Calendar.current.date(byAdding: .hour, value: i * 1, to: currentDate)!
            let formattedTime = DateFormatter.localizedString(from: time, dateStyle: .none, timeStyle: .short)
            let weather = "Weather \(i)"
            let temperature = "\(20 + i)°C"

            weatherData.append(WeatherModel(time: formattedTime, weather: weather, temperature: temperature))
        }

        return weatherData
    }
}

