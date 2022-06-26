//
//  ContentView.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import SwiftUI

struct ContentView: View {
    var weatherManager: WeatherManager = .shared
    
    @StateObject var currentWeather: CurrentWeather = CurrentWeather()
    @StateObject var todayForecast: TodayForecast = TodayForecast()
    
    var body: some View {
        VStack (alignment: .center, spacing: 10) {
            CurrentWeatherView(temp: currentWeather.temperature,
                               sky: currentWeather.sky,
                               pty: currentWeather.rainFallType)
            TodayForcastView(minTemp: todayForecast.minTemp,
                             maxTemp: todayForecast.maxTemp)

            Button  {
                weatherManager.fetchData(of: Date(),
                                         currentWeather: currentWeather,
                                         todayForecast: todayForecast)
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
