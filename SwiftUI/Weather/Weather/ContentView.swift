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
            TodayForcastView()

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
    var ultraSrtNcstInfo: NcstItem?
    
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
        return String(ultraSrtNcstInfo?.data["T1H"] ?? 0)
    }
    
    func getPTY() -> String {
        let value = ultraSrtNcstInfo?.data["PTY"]
        
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
    var body: some View {
        VStack {
            Text("오늘 날씨")
                .font(.title)
            Text("최고: 31°, 최저: 21°")
            Text("맑음")
            Text("강수 확률: 00%")
        }
    }
}
