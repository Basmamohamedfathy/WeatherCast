//
//  ContentView.swift
//  WeatherCast
//
//  Created by Basma on 05/02/2024.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
   
    @StateObject private var viewModel = ViewModel()
    @StateObject private var locationViewModel = LocationViewModel()
    @State private var backgroundImage :Image?
    @State private var datacome = false
    @State private var isMorning = false
    @State private var locationManager = CLLocationManager()
    @State private var queue = OperationQueue()
    @State private var showAlert = false
    @State private var longitude:CLLocationDegrees = 30.071
    @State private var latitude:CLLocationDegrees = 31.021
    
    var body: some View {
        NavigationView{
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
                        CustomTextView(text: "\(viewModel.result?.current.tempC ?? 0.0)°", isMorningColor:isMorning).font(.title)
                        CustomTextView(text: viewModel.result?.current.condition.text ?? "yes", isMorningColor:isMorning).font(.title)
                        HStack{
                            CustomTextView(text: "H: \(viewModel.result?.forecast.forecastday[0].day.maxtempC ?? 0)°", isMorningColor:isMorning).font(.title)
                            CustomTextView(text: "L: \(viewModel.result?.forecast.forecastday[0].day.mintempC ?? 0)°", isMorningColor:isMorning).font(.title)
                            
                        }
                        let url = viewModel.result?.current.condition.icon
                        if datacome == true{
                            URLImage(urlString:url ?? "")
                        }
                        CustomTextView(text: "3-Days ForeCast", isMorningColor: isMorning).padding(.trailing,190)
                        
                        ForecastList(isMorningColor: isMorning, longitude: longitude, latitude: latitude).listStyle(PlainListStyle()).scrollDisabled(true)
                        
                        BottomSection(isMorningColor: isMorning, longitude: longitude, latitude: latitude)
                       
                    } .padding(30)
                }else{
                   CustomTextView(text: "No Internet connen", isMorningColor: isMorning).font(.title)
                   
               }
                
            }
            .onAppear(){
                updateBackgroundColor()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    if locationViewModel.locationStatus == .authorizedWhenInUse{
                        let location = locationViewModel.userLocation
                        longitude = location?.longitude ?? 30
                        latitude = location?.latitude ?? 31
                        if location?.latitude != nil{
                            fetch()
                        }
                    }
                    else{
                        showAlert = true
                    }
                }
            }   .alert(isPresented: $showAlert){
                WeatherCast.alert()
                
            }
         
        }
    }
    func fetch(){
        let fetchData = BlockOperation{
                viewModel.fetchResult(Longitude: longitude, Latitude: latitude)
        }
        let fetchImage = BlockOperation{
            datacome = true
        }
       
        fetchImage.addDependency(fetchData)
        queue.addOperations([fetchData, fetchImage], waitUntilFinished: true)
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
func alert() -> Alert {
     return Alert(
         title: Text("SomeThing Wronge"),
         message: Text("SomeThing Wronge in access location please try to open your app again"),
         dismissButton: .default(Text("OK"), action: {
             UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
             exit(0)
          })
     )
 }
        
