//
//  ContentView.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import SwiftUI

struct ContentView: View {
    let weatherManager: WeatherManager = .shared
    @StateObject var locationManager = LocationManager()
    
    @StateObject var currentWeather: CurrentWeather = CurrentWeather()
    @StateObject var todayForecast: TodayForecast = TodayForecast()
    
    var body: some View {
        VStack (alignment: .center, spacing: 10) {
            CurrentWeatherView(locationString: locationManager.currentAddress,
                               temp: currentWeather.temperature,
                               sky: currentWeather.sky,
                               pty: currentWeather.rainFallType)
            TodayForcastView(minTemp: todayForecast.minTemp,
                             maxTemp: todayForecast.maxTemp)

        }
        .onAppear {
            // TODO: Fetch data faster or fetch before the launching
            weatherManager.fetchData(of: Date(),
                                     currentWeather: currentWeather,
                                     todayForecast: todayForecast,
                                     location: locationManager.currentLocation)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
