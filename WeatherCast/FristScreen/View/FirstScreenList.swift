//
//  FirstScreenList.swift
//  WeatherCast
//
//  Created by Mac on 06/02/2024.
//

import SwiftUI

struct ForecastList: View {
    @StateObject var viewModel = ViewModel()
    @State private var datacome = false
    var isMorningColor: Bool
    let counter = [1,2]
    var body: some View {
       
        List{
            if datacome == true{
                FirstScreenRow(day: "Today", imageName:viewModel.result?.forecast.forecastday[0].day.condition.icon.rawValue ?? "", lowestTempreture: "\(viewModel.result?.forecast.forecastday[0].day.maxtempC ?? 0)", highestTempreture: "\(viewModel.result?.forecast.forecastday[0].day.mintempC ?? 0)", isMorningColor: isMorningColor)
                    .listRowSeparator(.hidden)
                    .frame(height:40)
                    .listRowBackground(Color
                        .white
                        .opacity(0))
                
                ForEach(counter, id: \.self){ count in
                    
                    FirstScreenRow(day: formattedWeekday(dateString: viewModel.result?.forecast.forecastday[count].date ?? "0"), imageName: viewModel.result?.forecast.forecastday[count].day.condition.icon.rawValue ?? "", lowestTempreture: "\(viewModel.result?.forecast.forecastday[count].day.maxtempC ?? 0)", highestTempreture: "\(viewModel.result?.forecast.forecastday[count].day.mintempC ?? 0)", isMorningColor: isMorningColor)
                        .listRowSeparator(.hidden)
                        .frame(height:40)
                        .listRowBackground(Color
                            .white
                            .opacity(0))
                    
                }
            }
            
        }.scrollContentBackground(.hidden)
            .scrollDisabled(true)
            .onAppear(){
                viewModel.fetchResult()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    datacome = true
                }
            }
          
    }
    private func formattedWeekday(dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") 

            if let date = dateFormatter.date(from: dateString) {
                let weekdayFormatter = DateFormatter()
                weekdayFormatter.dateFormat = "EEE"
                return weekdayFormatter.string(from: date)
            }

            return ""
        }
}

