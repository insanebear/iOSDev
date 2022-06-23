//
//  ContentView+InfoViews.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/23.
//

import SwiftUI

struct CurrentWeatherView: View {
    var ultraSrtNcstInfo: WeatherItem?
    
    var temp: String {
        guard let ncstInfo = ultraSrtNcstInfo,
              let dateTime = ncstInfo.baseDateTime else {
            return "Unknown"
        }
        return String(ncstInfo.data[dateTime]!["T1H"]!)
    }
    
    var pty: String {
        guard let ncstInfo = ultraSrtNcstInfo,
              let dateTime = ncstInfo.baseDateTime else {
            return "Unknown"
        }
        
        let value = ncstInfo.data[dateTime]!["PTY"]!
        
        switch value {
        case 0: return "없음"
        case 1: return "비"
        case 2: return "비/눈"
        case 3: return "눈"
        case 5: return "빗방울"
        case 6: return "빗방울눈날림"
        case 7: return "눈날림"
        default: return ""
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
    var srtFcstInfo: WeatherItem?   // for Max, Min temp
    var ultraSrtFcstInfo: WeatherItem?
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmm"
        
        return formatter
    } ()
    
    var sky: String {
        let currentTimeString = Date().stringDateTime()
        let dateTimeString = currentTimeString.0 + currentTimeString.1 + "00"
        
        guard let ultraSrtFcstInfo = ultraSrtFcstInfo,
              let dateTime = dateFormatter.date(from: dateTimeString) else {
            return "Unknown"
        }
        
        let value = ultraSrtFcstInfo.data[dateTime]!["SKY"]
        switch value {
        case 1: return "맑음"
        case 3: return "구름많음"
        case 4: return "흐림"
        
        default: return "Unknown"
        }
    }
    
    var minTemp: String {
        let dateTimeString = Date().stringDateTime().0 + "0600" // Only avail at 06:00

        guard let srtFcstInfo = srtFcstInfo,
              let dateTime = dateFormatter.date(from: dateTimeString) else {
            return "Unknown"
        }
        
        return String(srtFcstInfo.data[dateTime]!["TMN"]!)
    }
    
    var maxTemp: String {
        let dateTimeString = Date().stringDateTime().0 + "1500" // Only avail at 15:00

        guard let srtFcstInfo = srtFcstInfo,
              let dateTime = dateFormatter.date(from: dateTimeString) else {
            return "Unknown"
        }
        
        return String(srtFcstInfo.data[dateTime]!["TMX"]!)
    }
    
    var pop: String {
        let currentTimeString = Date().stringDateTime()
        let dateTimeString = currentTimeString.0 + currentTimeString.1 + "00"
        
        guard let srtFcstInfo = srtFcstInfo,
              let dateTime = dateFormatter.date(from: dateTimeString) else {
            return "Unknown"
        }
        
        return String(srtFcstInfo.data[dateTime]!["POP"]!)
    }
    
    var body: some View {
        VStack {
            Text("오늘 날씨")
                .font(.title)
            Text("최고: \(maxTemp)°, 최저: \(minTemp)°")
            Text("\(sky)")
            Text("강수 확률: \(pop)%")
        }
    }
}
