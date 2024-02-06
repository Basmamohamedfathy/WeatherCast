//
//  FirstScreenList.swift
//  WeatherCast
//
//  Created by Mac on 06/02/2024.
//

import SwiftUI

struct ForecastList: View {
    var body: some View {
        
            List{
            
       
                
            FirstScreenRow(day: "today", imageName: "cloudy", lowestTempreture: "7.5", highestTempreture: "18.5")
                .listRowSeparator(.hidden)
                .frame(height:40)
                .listRowBackground(Color
                    .white
                    .opacity(0))
            
            FirstScreenRow(day: "today", imageName: "cloudy", lowestTempreture: "7.5", highestTempreture: "18.5")
                .listRowSeparator(.hidden)
                .frame(height:40)
                .listRowBackground(Color
                    .white
                    .opacity(0))
            
            FirstScreenRow(day: "today", imageName: "cloudy", lowestTempreture: "7.5", highestTempreture: "18.5")
                .listRowSeparator(.hidden)
                .frame(height:40)
                .listRowBackground(Color
                    .white
                    .opacity(0))
            
        }.scrollContentBackground(.hidden)
                .scrollDisabled(true)
        
        
    }
}

struct ForecastList_Previews: PreviewProvider {
    static var previews: some View {
        ForecastList()
    }
}
