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
            Text("\(getTemperature())°")
            Text("맑음")
            Text("최고: 31°, 최저: 21°")
            
            Button  {
                weatherManager.fetchData(of: currentTime)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
