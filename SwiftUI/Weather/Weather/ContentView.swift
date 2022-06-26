//
//  ContentView.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherManager = WeatherManager()
    
    var body: some View {
        VStack (alignment: .center, spacing: 10) {
            CurrentWeatherView(temp: weatherManager.currentWeather.temperature,
                               sky: weatherManager.currentWeather.sky,
                               pty: weatherManager.currentWeather.rainFallType)
            TodayForcastView(minTemp: weatherManager.todayForecast.minTemp,
                             maxTemp: weatherManager.todayForecast.maxTemp)

            Button  {
                weatherManager.fetchData(of: Date())
            } label: {
                Text("Get weather data")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
