//
//  ContentView.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import SwiftUI

struct ContentView: View {
    @State var time: Date = Date()
    let weatherManager: WeatherManager = .shared
    @StateObject var locationManager = LocationManager()
    
    @StateObject var currentWeather: CurrentWeather = CurrentWeather()
    @StateObject var todayForecast: TodayForecast = TodayForecast()
    
    var body: some View {
        VStack (alignment: .center, spacing: 10) {
            Spacer()
            Text("\(locationManager.currentAddress)")
                .font(.title)
            
            TopInfoView(temp: currentWeather.temperature,
                        sky: currentWeather.sky,
                        pty: currentWeather.rainFallType,
                        minTemp: todayForecast.minTemp,
                        maxTemp: todayForecast.maxTemp,
                        pop: todayForecast.probRain)
            TodayForcastView()
            Spacer()
        }
        .onAppear {
            // TODO: Fetch data faster or fetch before the launching
            #if DEBUG
            time = Date().dateAt(hours: 00, minutes: 30)
            #endif
            weatherManager.fetchData(of: time,
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
