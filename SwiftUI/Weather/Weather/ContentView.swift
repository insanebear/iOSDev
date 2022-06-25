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
            CurrentWeatherView(weatherManager: weatherManager)
            TodayForcastView(weatherManager: weatherManager)

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
