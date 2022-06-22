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
            Text("OO시")
            Text("온도: \(getTemperature())°")
            Text("강수 형태: \(getPTY())")
            Text("최고: 31°, 최저: 21°")
            
            Button  {
                weatherManager.fetchData(of: currentTime.hourBefore)
            } label: {
                Text("Hit me")
            }
            Button  {
                print(weatherManager.weatherInfo)
                print(weatherManager.weatherInfo?.baseDateTime?.stringDateTime())
            } label: {
                Text("Print console")
            }
        }
    }
    
    func getTemperature() -> String {
        return String(weatherManager.weatherInfo?.data["T1H"] ?? 0)
    }
    
    func getPTY() -> String {
        let value = weatherManager.weatherInfo?.data["PTY"]
        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
