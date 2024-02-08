//
//  BottomSection.swift
//  WeatherCast
//
//  Created by Basma on 06/02/2024.
//

import SwiftUI

struct BottomSection: View {
    @StateObject var viewModel = ViewModel()
    var isMorningColor: Bool
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 10) {
                     
            VStack {
                CustomTextView(text: "visibility", isMorningColor: isMorningColor)
                    .frame(width: 150, height: 40).font(.title)
                
                CustomTextView(text:"\(viewModel.result?.current.visKM ?? 0) KM", isMorningColor: isMorningColor)
                    .frame(width: 150, height: 40).font(.title)
                
            }

             
            VStack {
                CustomTextView(text: "humidity", isMorningColor: isMorningColor)
                    .frame(width: 150, height: 40).font(.title)
                
                CustomTextView(text:"\(viewModel.result?.current.humidity ?? 0) %", isMorningColor: isMorningColor)
                    .frame(width: 150, height: 40).font(.title)
            }

            VStack {
                CustomTextView(text: "feels like ", isMorningColor: isMorningColor)
                    .frame(width: 150, height: 40).font(.title)
                
                CustomTextView(text:"\(viewModel.result?.current.feelslikeC ?? 0) ", isMorningColor: isMorningColor)
                    .frame(width: 150, height: 40).font(.title)
            }

            VStack {
                CustomTextView(text: "pressure", isMorningColor: isMorningColor)
                    .frame(width: 150, height: 40).font(.title)
                
                CustomTextView(text:"\(viewModel.result?.current.pressureIn ?? 0) ", isMorningColor: isMorningColor)
                    .frame(width: 150, height: 40).font(.title)
                
            }
        }.onAppear(){
            viewModel.fetchResult()
        }
    }
}


