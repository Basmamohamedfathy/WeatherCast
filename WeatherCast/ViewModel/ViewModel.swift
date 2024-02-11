//
//  ViewModel.swift
//  app
//
//  Created by Basma on 05/02/2024.
//

import Foundation
import CoreLocation
class ViewModel:ObservableObject{

@Published var result :Welcome?
   
    func fetchResult(Longitude:CLLocationDegrees,Latitude:CLLocationDegrees){
          guard let new = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=18d464653df7439aaff112944240502&q=\(Longitude),\(Latitude)&days=3&aqi=yes&alerts=no") else{
     
            return
            }

            let request = URLRequest(url: new)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                guard let data = data else{
                    return
                }
                do{
                    
                    let result = try JSONDecoder().decode(Welcome.self, from: data)
                    DispatchQueue.main.async {
                        self.result = result
                    }
                }catch let error{
                    print(error)
                    
                }
            }
            task.resume()
             
        }
  
}





