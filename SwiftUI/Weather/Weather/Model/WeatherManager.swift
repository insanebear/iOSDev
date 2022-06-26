//
//  WeatherManager.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import Foundation
import CoreLocation

class WeatherManager {
    static let shared = WeatherManager()
    
    func fetchData(of queryTime: Date, currentWeather: CurrentWeather, todayForecast: TodayForecast, location: CLLocation?) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let decoder = JSONDecoder()
        
        // get url
        var urlList: [WeatherOperation: URL] = [:]
        
        for operation in WeatherOperation.allCases {
            let url = getURL(operation: operation, queryTime: queryTime, location: location)
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
    
    func getURL(operation: WeatherOperation, queryTime: Date, location: CLLocation?) -> URL {
        // get a proper base_time to make url
        let time = getBaseTime(operation: operation, time: queryTime)
        var lccCoordinate: (Int, Int)!
        
        guard let location = location else {
            fatalError("No location")
        }
        lccCoordinate = convertCoordinate(location: location)
        
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
        
        let nx = URLQueryItem(name: "nx", value: "\(lccCoordinate.0)")
        let ny = URLQueryItem(name: "ny", value: "\(lccCoordinate.1)")
        
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

extension WeatherManager {
    struct WeatherMapConstant {
        var re = 6371.00877     // 지도 반경
        var grid = 5.0          // 격자 간격 (km)
        var slat1 = 30.0        // 표준 위도 1
        var slat2 = 60.0        // 표준 위도 2
        var olon = 126.0        // 기준점 경도
        var olat = 38.0         // 기준점 위도
        var xo: Double { 210 / grid } // 기준점 x 좌표
        var yo: Double { 675 / grid } // 기준점 y 좌표
        var first = 0           // 시작 여부 (0 = 시작)
    }
    
    func convertCoordinate(location: CLLocation) -> (Int, Int) {
        let constants = WeatherMapConstant()
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        
        let radian = .pi/180.0
        
        let re = constants.re / constants.grid
        let slat1 = constants.slat1 * radian
        let slat2 = constants.slat2 * radian
        let olon = constants.olon * radian
        let olat = constants.olat * radian
        
        var sn = tan(.pi * 0.25 + slat2 * 0.5) / tan(.pi * 0.25 + slat1 * 0.5)
        sn = log(cos(slat1) / cos(slat2)) / log(sn)
        
        var sf = tan(.pi * 0.25 + slat1 * 0.5)
        sf = pow(sf, sn) * cos(slat1) / sn
        
        var ro = tan(.pi * 0.25 + olat * 0.5)
        ro = re * sf / pow(ro, sn)
        
        var ra = tan(.pi * 0.25 + lat * radian * 0.5)
        ra = re * sf / pow(ra, sn)
        var theta = long * radian - olon
        if theta > .pi {
            theta -= 2.0 * .pi
        }
        if theta < (-1 * .pi) {
            theta += 2.0 * .pi
        }
        theta *= sn
        
        let x = ra*sin(theta) + constants.xo + 1.5
        let y = (ro - ra*cos(theta)) + constants.yo + 1.5
        
        return (Int(x), Int(y))
    }
}
