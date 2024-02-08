//
//  ViewModel.swift
//  app
//
//  Created by Basma on 05/02/2024.
//

import Foundation
class ViewModel:ObservableObject{

@Published var result :Welcome?

func fetchResult(){
          guard let new = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=18d464653df7439aaff112944240502&q=30.0715495,31.0215953&days=3&aqi=yes&alerts=no") else{
     
            return
            }

           let request = URLRequest(url: new)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                guard let data = data else{
                    return
                }
                print(data)
                print("background")
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





