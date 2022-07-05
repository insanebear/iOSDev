//
//  ContentView+InfoViews.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/23.
//

import SwiftUI
import CoreLocation

struct TopInfoView: View {
    /// presents current weather and today's forecast summary
    var temp: String
    var sky: String
    var pty: String
    var minTemp: String
    var maxTemp: String
    var pop: String
    
    var body: some View {
        VStack {
            VStack {
                // current weather
                Text("\(temp)°")
                    .font(.system(size: 70))
                Text("강수 형태: \(pty)")
                Text("하늘 상태: \(sky)")
            }
            .padding(.bottom, 20)
            VStack {
                Text("최고: \(maxTemp)°, 최저: \(minTemp)°")
                Text("강수 확률: \(pop)%")
            }
        }
    }
}

struct TodayForcastView: View {
    /// presents today's forecasts per hour
    
    var body: some View {
        VStack {
            
        }
    }
}

//struct
