//
//  ContentView+InfoViews.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/23.
//

import SwiftUI

struct CurrentWeatherView: View {
    @ObservedObject var weatherManager: WeatherManager
    
    var temp: String {
        return String(weatherManager.currentWeather.temperature)
    }
    
    var sky: String {
        
        let value = weatherManager.currentWeather.sky
        switch value {
        case 1: return "맑음"
        case 3: return "구름많음"
        case 4: return "흐림"
        
        default: return "Unknown"
        }
    }
    
    var pty: String {
        
        let value = weatherManager.currentWeather.rainFallType
        
        switch value {
        case 0: return "없음"
        case 1: return "비"
        case 2: return "비/눈"
        case 3: return "눈"
        case 5: return "빗방울"
        case 6: return "빗방울눈날림"
        case 7: return "눈날림"
        default: return "Unknown"
        }
    }
    
    var body: some View {
        VStack {
            Text("현재 날씨")
                .font(.title)
            Text("OO시")
            Text("온도: \(temp)°")
            Text("강수 형태: \(pty)")
        }
    }
}

struct TodayForcastView: View {
    @ObservedObject var weatherManager: WeatherManager
    
    var minTemp: String {
        return String(weatherManager.todayWeather.minTemp)
    }
    
    var maxTemp: String {
        return String(weatherManager.todayWeather.maxTemp)
    }
    
//    var pop: String {
//        return String(todayWeather.probRain)
//    }
    
    var body: some View {
        VStack {
            Text("오늘 날씨 예보")
                .font(.title)
            Text("최고: \(maxTemp)°, 최저: \(minTemp)°")
//            Text("강수 확률: \(pop)%")
        }
    }
}
