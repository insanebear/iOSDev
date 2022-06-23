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
            TodayForcastView(srtFcstInfo: weatherManager.srtFcstInfo,
                             ultraSrtFcstInfo: weatherManager.ultraSrtFcstInfo)

            Button  {
                weatherManager.fetchData(of: currentTime.hourBefore)
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
