//
//  SecondScreen.swift
//  WeatherCast
//
//  Created by Basma on 07/02/2024.
//

import SwiftUI
import CoreLocation

struct WeatherCell: View {
    
    let time: String
    let weather: String
    let temperature: String
    var isMorningColor: Bool
    var body: some View {
        HStack {
            CustomTextView(text: time, isMorningColor:isMorningColor) .font(.system(size: 25))
            Spacer()
            URLImage(urlString: weather)
            Spacer()
            CustomTextView(text: temperature, isMorningColor:isMorningColor) .font(.system(size: 25))
        }
        .padding()
    }
}

struct WeatherList: View {
    @State private var backgroundImage :Image?
    @StateObject var viewModel = ViewModel()
    @State private var queue = OperationQueue()
    @State private var datacome = false
    var longitude:CLLocationDegrees
    var latitude:CLLocationDegrees
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
                        WeatherCell(time: "Now", weather: viewModel.result?.forecast.forecastday[0].hour[Calendar.current.component(.hour, from: Date())].condition.icon ?? "", temperature: "\(viewModel.result?.forecast.forecastday[0].hour[Calendar.current.component(.hour, from: Date())].tempC ?? 0)°" , isMorningColor: isMorningColor).listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        ForEach(Calendar.current.component(.hour, from: Date())..<23,id: \.self) { index in
                            WeatherCell(time:index+1 < 11 ? "\(index+1) AM" : "\(index+1) PM", weather: viewModel.result?.forecast.forecastday[0].hour[index+1].condition.icon ?? "", temperature: "\(viewModel.result?.forecast.forecastday[0].hour[index+1].tempC ?? 0)°" , isMorningColor: isMorningColor).listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        }           
                    }else{
                            ForEach(0..<24,id: \.self) { index in
                                
                                WeatherCell(time: index < 11 ? "\(index) AM" : "\(index) PM", weather: viewModel.result?.forecast.forecastday[0].hour[index].condition.icon ?? "", temperature: "\(viewModel.result?.forecast.forecastday[0].hour[index].tempC ?? 0)°" , isMorningColor: isMorningColor).listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                            }
                        }
                }
                
            }.listStyle(PlainListStyle()).padding(20)
               
        }
        .scrollClipDisabled()
        .navigationTitle("Hourly Forecast")
        .onAppear(){
            updateBackgroundColor()
            let fetchData = BlockOperation{
                viewModel.fetchResult(Longitude: longitude, Latitude: latitude)
            }
            let fetchImage = BlockOperation{
                datacome = true
            }
            fetchImage.addDependency(fetchData)
            queue.addOperations([fetchData, fetchImage], waitUntilFinished: true)
            
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
