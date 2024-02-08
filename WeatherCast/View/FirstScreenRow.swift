//
//  FristScreenRow.swift
//  WeatherCast
//
//  Created by Mac on 06/02/2024.
//

import Foundation
import SwiftUI

struct FirstScreenRow: View {
    
    let day:String
    let imageName:String
    let lowestTempreture:String
    let highestTempreture:String
    var isMorningColor: Bool
    var body: some View {
        VStack{
           
             Divider()
                .frame(minHeight: 1.5)
                   .overlay(Color.black)
        
            HStack{
            
                CustomTextView(text: "\(day)", isMorningColor: isMorningColor).font(.system(size: 21))
                Spacer()
                URLImage(urlString: imageName)
                Spacer()
                CustomTextView(text: "\(lowestTempreture)°", isMorningColor: isMorningColor).font(.system(size: 21))
                Text("-")
                    .font(.system(size: 23))
                CustomTextView(text: "\(highestTempreture)°", isMorningColor: isMorningColor).font(.system(size: 21))
            }

        }
    }
}

/*struct ForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreenRow(day: "today", imageName: "cloudy", lowestTempreture: "7.5", highestTempreture: "18.5")
    }
}*/
