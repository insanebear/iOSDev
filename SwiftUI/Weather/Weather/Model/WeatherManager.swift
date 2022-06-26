//
//  WeatherManager.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import Foundation

class WeatherManager {
    static let shared = WeatherManager()

    func fetchData(of queryTime: Date, currentWeather: CurrentWeather, todayForecast: TodayForecast) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let decoder = JSONDecoder()
        
        // get url
        var urlList: [WeatherOperation: URL] = [:]
        
        for operation in WeatherOperation.allCases {
            let url = getURL(operation: operation, queryTime: queryTime)
            urlList[operation] = url
        }
        
        // fetch and decode data from url
        for (operation, url) in urlList {
            let task = session.dataTask(with: url) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                      let data = data else {
                    fatalError()
                }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    fatalError("Response code: \(httpResponse.statusCode)")
                }
                
                DispatchQueue.main.async {
                    switch operation {
                    case .ultraSrtNcst:
                        guard let ncstItemService = try? decoder.decode(NcstItemService.self, from: data) else {
                            fatalError("UltraSrtNcst: Cannot decode as NcstItemService")
                        }
                        let usNcstWeatherData = NcstWeatherItem(from: ncstItemService)

                        // update all currentWeather except SKY
                        currentWeather.updateDataNcst(with: usNcstWeatherData)
                        
                    case .ultraSrtFcst:
                        guard let fcstItemService = try? decoder.decode(FcstItemService.self, from: data) else {
                            fatalError("UltraSrtFcst: Cannot decode as FcstItemService")
                        }
                        let usFcstWeatherData = FcstWeatherItem(from: fcstItemService)
                        
                        // update SKY in currentWeather
                        currentWeather.updateDataFcst(with: usFcstWeatherData, queryTime: queryTime)
                        
                    case .vilageFcst:
                        guard let fcstItemService = try? decoder.decode(FcstItemService.self, from: data) else {
                            fatalError("VilageFcst: Cannot decode as FcstItemService")
                        }

                        let vilageFcstWeatherData = FcstWeatherItem(from: fcstItemService)
                        todayForecast.updateVilageFcstData(with: vilageFcstWeatherData, queryTime: queryTime)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func getURL(operation: WeatherOperation, queryTime: Date) -> URL {
        // get a proper base_time to make url
        let time = getBaseTime(operation: operation, time: queryTime)
        
        // build url components
        guard let privateKey = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String else {
            fatalError("Cannot find weather API Key")
        }
        let queryTimeString = time.stringDateTime()
        let dateString = queryTimeString.0
        let timeString = queryTimeString.1 + queryTimeString.2
        
        let serviceKey = URLQueryItem(name: "serviceKey", value: privateKey)
        let numOfRows = URLQueryItem(name: "numOfRows", value: "1000")
        let pageNo = URLQueryItem(name: "pageNo", value: "1")
        let dataType = URLQueryItem(name: "dataType", value: "JSON")
        let base_date = URLQueryItem(name: "base_date", value: "\(dateString)")
        let base_time = URLQueryItem(name: "base_time", value: "\(timeString)")
        
        let nx = URLQueryItem(name: "nx", value: "55")
        let ny = URLQueryItem(name: "ny", value: "127")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "apis.data.go.kr"
        urlComponents.path = "/1360000/VilageFcstInfoService_2.0/\(operation.urlPath)"
        urlComponents.queryItems = [serviceKey, numOfRows, pageNo, dataType, base_date, base_time, nx, ny]
        
        // to encode '+' using percent encoding properly
        let characterSet = CharacterSet(charactersIn: "/+").inverted
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.addingPercentEncoding(withAllowedCharacters: characterSet)
        
        guard let url = urlComponents.url else {
            fatalError()
        }
        return url
    }
    
    
    func getBaseTime(operation: WeatherOperation, time: Date) -> Date {
        
        guard let hours = Int(time.stringDateTime().1),
              let minutes = Int(time.stringDateTime().2) else {
            fatalError("Cannot convert Date() to hours and minutes String")
        }
        
        var baseTime = time
        
        switch operation {
        case .ultraSrtNcst:
            if minutes < 30 { baseTime = time.hourBefore }
        case .ultraSrtFcst:
            // to get the today's forcast
            baseTime = time.hourBefore
        case .vilageFcst:
            // only use base_time 02:00 to get TMN, TMX, POP
            var newBaseTimeString = ""
            
            if hours < 2 || (hours == 2 && minutes < 10) {
                newBaseTimeString = time.dayBefore.stringDateTime().0 + "0200"
            } else {
                newBaseTimeString = time.stringDateTime().0 + "0200"
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMddHHmm"
            guard let newDate = dateFormatter.date(from: newBaseTimeString) else {
                fatalError("Fail to create a new base time")
            }
            
            baseTime = newDate
        }
        
        return baseTime
    }
}
