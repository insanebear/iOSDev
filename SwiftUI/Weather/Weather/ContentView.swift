//
//  ContentView.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherManager = WeatherManager()
    @State var currentTime: Date = Date()
    
    var body: some View {
        VStack (alignment: .center, spacing: 10) {
            CurrentWeatherView(ultraSrtNcstInfo: weatherManager.ultraSrtNcstInfo)
            TodayForcastView(srtFcstInfo: weatherManager.srtFcstInfo)

            Button  {
                weatherManager.fetchData(of: currentTime.hourBefore)
            } label: {
                Text("Hit me")
            }
            Button  {
                // FIXME: srtFcst query time. Use the provided times.
                print(weatherManager.ultraSrtNcstInfo)
                print(weatherManager.ultraSrtFcstInfo)
                print(weatherManager.srtFcstInfo)
            } label: {
                Text("Print console")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CurrentWeatherView: View {
    var ultraSrtNcstInfo: WeatherItem?
    
    var body: some View {
        VStack {
            Text("현재 날씨")
                .font(.title)
            Text("OO시")
            Text("온도: \(getTemperature())°")
            Text("강수 형태: \(getPTY())")
        }
    }
    
    func getTemperature() -> String {
        guard let ncstInfo = ultraSrtNcstInfo,
              let dateTime = ncstInfo.baseDateTime else {
            return "Unknown"
        }
        return String(ncstInfo.data[dateTime]!["T1H"]!)
    }
    
    func getPTY() -> String {
        
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
        case 4: return "소나기"
        case 5: return "빗방울"
        case 6: return "빗방울눈날림"
        case 7: return "눈날림"
        default: return ""
        }
    }
}

struct TodayForcastView: View {
    // TODO: Modify the logic getting data more resonable
    var srtFcstInfo: WeatherItem?
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            Text("오늘 날씨")
                .font(.title)
            Text("최고: \(getMaxTemp())°, 최저: \(getMinTemp())°")
            Text("\(getSKY())")
            Text("강수 확률: \(getPOP())%")
        }
    }
    
    func getMinTemp() -> String {
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        
        let dateTime = Date().stringDateTime().0 + "0600"

        guard let srtFcstInfo = srtFcstInfo,
              let d = dateFormatter.date(from: dateTime) else {
            return "Unknown"
        }
        
        return String(srtFcstInfo.data[d]!["TMN"]!)
    }
    
    func getMaxTemp() -> String {
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        
        let dateTimeString = Date().stringDateTime().0 + "1500"

        guard let srtFcstInfo = srtFcstInfo,
              let d = dateFormatter.date(from: dateTimeString) else {
            return "Unknown"
        }
        
        return String(srtFcstInfo.data[d]!["TMX"]!)
    }
    
    func getPOP() -> String {
        dateFormatter.dateFormat = "HH"
        let dateTimeString = Date().stringDateTime().0 + dateFormatter.string(from: Date()) + "00"
        
        dateFormatter.dateFormat = "yyyyMMddHHmm"

        guard let srtFcstInfo = srtFcstInfo,
              let d = dateFormatter.date(from: dateTimeString) else {
            return "Unknown"
        }
        
        return String(srtFcstInfo.data[d]!["POP"]!)
    }
    
    func getSKY() -> String {
        dateFormatter.dateFormat = "HH"
        let dateTimeString = Date().stringDateTime().0 + dateFormatter.string(from: Date()) + "00"
        
        dateFormatter.dateFormat = "yyyyMMddHHmm"

        guard let srtFcstInfo = srtFcstInfo,
              let d = dateFormatter.date(from: dateTimeString) else {
            return "Unknown"
        }
        
        
        let value = srtFcstInfo.data[d]!["SKY"]!

        switch value {
        case 1: return "맑음"
        case 3: return "구름많음"
        case 4: return "흐림"
        
        default: return "Unknown"
        }
    }
}
