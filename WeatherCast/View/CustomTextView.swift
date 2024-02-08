//
//  CustomTextView.swift
//  WeatherCast
//
//  Created by Basma on 07/02/2024.
//

import SwiftUI

struct CustomTextView: View {
    var text: String
    var isMorningColor: Bool

    var body: some View {
        Text(text)
            .foregroundColor(isMorningColor ?  .black : .white)
   
    }
}
