//
//  WeatherManager.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import CoreLocation

class WeatherManager {
    static let shared = WeatherManager()
    
    func fetchData(of queryTime: Date, currentWeather: CurrentWeather, todayForecast: TodayForecast, location: CLLocation?) {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let decoder = JSONDecoder()
        
        // get url
        var urlList: [WeatherOperation: [URL]] = [:]
        
        for operation in WeatherOperation.allCases {
            let url = getURL(operation: operation, queryTime: queryTime, location: location)
            urlList[operation] = url
        }
        
        // fetch and decode data from url
        for (operation, urls) in urlList {
            for url in urls{
                let task = session.dataTask(with: url) { data, response, error in
                    guard let httpResponse = response as? HTTPURLResponse,
                          let data = data else {
                        fatalError()
                    }
                    
                    guard (200..<300).contains(httpResponse.statusCode) else {
                        // FIXME: Unknown response time out error
                        // it might be the cause of slow fetching
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
        
    }
    
    func getURL(operation: WeatherOperation, queryTime: Date, location: CLLocation?) -> [URL] {
        var lccCoordinate: (Int, Int)!
        
        guard let location = location else {
            fatalError("No location")
        }
        lccCoordinate = convertCoordinate(location: location)
        
        // build url components
        guard let privateKey = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String else {
            fatalError("Cannot find weather API Key")
        }

        let serviceKey = URLQueryItem(name: "serviceKey", value: privateKey)
        let numOfRows = URLQueryItem(name: "numOfRows", value: "1000")
        let pageNo = URLQueryItem(name: "pageNo", value: "1")
        let dataType = URLQueryItem(name: "dataType", value: "JSON")
        
        let nx = URLQueryItem(name: "nx", value: "\(lccCoordinate.0)")
        let ny = URLQueryItem(name: "ny", value: "\(lccCoordinate.1)")
        
        // get a proper base_time to make url
        let baseTimeList = getBaseTime(operation: operation, currentTime: queryTime)
        var urls: [URL] = []
        
        for baseTime in baseTimeList {
            let dateString = baseTime.stringDateTime().0
            let timeString = baseTime.stringDateTime().1 + baseTime.stringDateTime().2
            
            let base_date = URLQueryItem(name: "base_date", value: "\(dateString)")
            let base_time = URLQueryItem(name: "base_time", value: "\(timeString)")
            
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
            
            urls.append(url)
        }
        
        return urls
    }
    
    func getBaseTime(operation: WeatherOperation, currentTime: Date) -> [Date] {
        var baseTimeList: [Date] = []
        
        guard let hours = Int(currentTime.stringDateTime().1),
              let minutes = Int(currentTime.stringDateTime().2) else {
            fatalError("Cannot convert Date() to hours and minutes String")
        }
        
        switch operation {
        case .ultraSrtNcst:
            if minutes < 30 { baseTimeList.append(currentTime.hourBefore) }
            else { baseTimeList.append(currentTime) }
        case .ultraSrtFcst:
            // to get the today's forcast
            baseTimeList.append(currentTime.hourBefore)
        case .vilageFcst:
            
            // 0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300
            if currentTime < currentTime.dateAt(hours: 03, minutes: 00) {
                // use data of yesterday
                let baseTime = currentTime.dayBefore.dateAt(hours: 23, minutes: 00)
                baseTimeList.append(baseTime)
            } else {
                var baseTime: Date!
                
                switch hours {
                case 6...8:
                    baseTime = currentTime.dateAt(hours: 5, minutes: 00)
                    baseTimeList.append(baseTime)
                case 9...11:
                    baseTime = currentTime.dateAt(hours: 8, minutes: 00)
                    baseTimeList.append(baseTime)
                case 15...17:
                    baseTime = currentTime.dateAt(hours: 14, minutes: 00)
                    baseTimeList.append(baseTime)
                case 18...20:
                    baseTime = currentTime.dateAt(hours: 17, minutes: 00)
                    baseTimeList.append(baseTime)
                case 21...23:
                    baseTime = currentTime.dateAt(hours: 20, minutes: 00)
                    baseTimeList.append(baseTime)
                default:
                    break
                }
                
                if 12 <= hours {
                    baseTime = currentTime.dateAt(hours: 11, minutes: 00) // Today's TMX
                    baseTimeList.append(baseTime)
                }
                
                baseTime = currentTime.dateAt(hours: 02, minutes: 00) // Today's TMN
                baseTimeList.append(baseTime)
            }
        }

        return baseTimeList
    }
}
