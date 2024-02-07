//
//  SecondScreen.swift
//  WeatherCast
//
//  Created by Basma on 07/02/2024.
//

import SwiftUI

struct WeatherCell: View {
    let time: String
    let weather: String
    let temperature: String
    var isMorningColor: Bool
    var body: some View {
        HStack {
            CustomTextView(text: time, isMorningColor:isMorningColor ) .font(.headline)
            URLImage(urlString: weather)
            CustomTextView(text: temperature, isMorningColor:isMorningColor ) .font(.headline)
        }
        .padding()
    }
}

struct WeatherList: View {
    @State private var backgroundImage :Image?
    @StateObject var viewModel = ViewModel()
    @State private var datacome = false
    var isMorningColor: Bool
    let day: Int
    
    var body: some View {
        ZStack {
            if let background = backgroundImage {
                background
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }
            List {
                if datacome{
                    if day == 0 {
                        WeatherCell(time: "Now", weather: viewModel.result?.forecast.forecastday[0].hour[Calendar.current.component(.hour, from: Date())].condition.icon.rawValue ?? "", temperature: "\(viewModel.result?.forecast.forecastday[0].hour[Calendar.current.component(.hour, from: Date())].tempC ?? 0)" , isMorningColor: isMorningColor).listRowBackground(Color.clear)
                        ForEach(Calendar.current.component(.hour, from: Date())..<23,id: \.self) { index in
                            WeatherCell(time:"\(index+1)", weather: viewModel.result?.forecast.forecastday[0].hour[index+1].condition.icon.rawValue ?? "", temperature: "\(viewModel.result?.forecast.forecastday[0].hour[index+1].tempC ?? 0)" , isMorningColor: isMorningColor).listRowBackground(Color.clear)
                        }            }else{
                            ForEach(0..<24,id: \.self) { index in
                                
                                WeatherCell(time: String(viewModel.result?.forecast.forecastday[0].hour[index].time .dropFirst(11) ?? ""), weather: viewModel.result?.forecast.forecastday[0].hour[index].condition.icon.rawValue ?? "", temperature: "\(viewModel.result?.forecast.forecastday[0].hour[index].tempC ?? 0)" , isMorningColor: isMorningColor).listRowBackground(Color.clear)                            }
                        }
                    
                }
                
            }.listStyle(PlainListStyle()).padding(50)
        }
        .navigationTitle("Hourly Forecast")
        .onAppear(){
            updateBackgroundColor()
            viewModel.fetchResult()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                datacome = true
               
            }
            
        }
    }
    private func updateBackgroundColor() {
            let hour = Calendar.current.component(.hour, from: Date())

        if (5..<18).contains(hour) {
            backgroundImage = Image("morningImage")

        } else {
            backgroundImage = Image("eveningImage")
          
                }
        }
}
