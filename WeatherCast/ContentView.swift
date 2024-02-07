//
//  ContentView.swift
//  WeatherCast
//
//  Created by Basma on 05/02/2024.
//

import SwiftUI

struct ContentView: View {
   
    @StateObject var viewModel = ViewModel()
    @State private var backgroundImage :Image?
    @State private var datacome = false
    @State private var isMorning = false
        var body: some View {
            ZStack {
                if let background = backgroundImage {
                                background
                                    .resizable()
                                    .scaledToFill()
                                    .edgesIgnoringSafeArea(.all)
                            }
                if viewModel.result != nil{
                    VStack{
                        Spacer()
                        CustomTextView(text: viewModel.result?.location.name ?? "No", isMorningColor:isMorning).font(.largeTitle)
                        CustomTextView(text: "\(viewModel.result?.current.tempC ?? 0)", isMorningColor:isMorning).font(.title)
                        CustomTextView(text: viewModel.result?.current.condition.text ?? "yes", isMorningColor:isMorning).font(.title)
                        HStack{
                            CustomTextView(text: "H: \(viewModel.result?.forecast.forecastday[0].day.maxtempC ?? 0)", isMorningColor:isMorning).font(.title)
                            CustomTextView(text: "L: \(viewModel.result?.forecast.forecastday[0].day.mintempC ?? 0)", isMorningColor:isMorning).font(.title)
                         
                        }
                        let url = viewModel.result?.current.condition.icon.rawValue
                        if datacome == true{
                            URLImage(urlString:url ?? "")
                        }
                        CustomTextView(text: "3-Days ForeCast", isMorningColor: isMorning)
                        ForecastList(isMorningColor: isMorning).listStyle(PlainListStyle())
                        BottomSection(isMorningColor: isMorning)
                        Spacer()
                    } .padding(50)
                }else{
                    Image ("sy")
                        .resizable()
                        .aspectRatio(contentMode:.fit) .frame(width: 100, height: 40) .background(Color.gray)
                    CustomTextView(text: "No Internet", isMorningColor: isMorning)
                }
                
            }
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
            isMorning = true
        } else {
            backgroundImage = Image("eveningImage")
            isMorning = false
                }
        }
    
    
    }
        
