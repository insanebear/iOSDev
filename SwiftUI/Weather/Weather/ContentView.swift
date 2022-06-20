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
            Text("OO시")
            Text("24°")
            Text("맑음")
            Text("최고: 31°, 최저: 21°")
            
            Button  {
                weatherManager.fetchData()
            } label: {
                Text("Hit me")
            }
            Button  {
                for item in weatherManager.weatherItems {
                    print(item)
                }
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
