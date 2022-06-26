//
//  ContentView+InfoViews.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/23.
//

import SwiftUI

struct CurrentWeatherView: View {
    var temp: String
    var sky: String
    var pty: String
    
    var body: some View {
        VStack {
            Text("현재 날씨")
                .font(.title)
            Text("OO시")
            Text("온도: \(temp)°")
            Text("강수 형태: \(pty)")
            Text("하늘 상태: \(sky)")
        }
    }
}

struct TodayForcastView: View {
    var minTemp: String
    var maxTemp: String
//    var pop: String
    
    var body: some View {
        VStack {
            Text("오늘 날씨 예보")
                .font(.title)
            Text("최고: \(maxTemp)°, 최저: \(minTemp)°")
//            Text("강수 확률: \(pop)%")
        }
    }
}
