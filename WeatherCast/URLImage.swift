//
//  URLImage.swift
//  WeatherCast
//
//  Created by Basma on 06/02/2024.
//

import SwiftUI

struct URLImage: View {
    
    let urlString: String
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image (uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame (width: 100, height: 60)
        }else {
            Image ("")
                .resizable()
                .aspectRatio(contentMode:.fit) .frame(width: 100, height: 40) .background(Color.gray)
                .onAppear {
                    fetchData()
                
                }
        }
    }
    private func fetchData(){
        guard let url = URL(string:"https:".appending(urlString)) else{
            print(urlString)
            return
        }
        print("urlString")
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            self.data = data
          
        }
        task.resume()
    }
}

