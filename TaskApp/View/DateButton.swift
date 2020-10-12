//
//  DateButton.swift
//  TaskApp
//
//  Created by Igor P-V on 12.10.2020.
//

import SwiftUI

struct DateButton: View {
    
    var title: String
    @ObservedObject var homeData: HomeViewModel
    
    var body: some View {
        Button(action: { homeData.updateDate(value: title)}, label: {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(homeData.checkDate() == title ? .white : .gray)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(
                    homeData.checkDate() == title ?
                    LinearGradient(gradient: .init(colors: [Color(#colorLiteral(red: 0.737254902, green: 0.5607843137, blue: 0.5607843137, alpha: 1)), Color(#colorLiteral(red: 0.9568627451, green: 0.6431372549, blue: 0.3764705882, alpha: 1))]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                        : LinearGradient(gradient: .init(colors: [Color.white]),
                                         startPoint: .leading,
                                         endPoint: .trailing)
                )
                .cornerRadius(6)
        })
        
    }
}

