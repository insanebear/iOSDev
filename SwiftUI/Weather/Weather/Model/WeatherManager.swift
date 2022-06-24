//
//  WeatherManager.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import Foundation

class WeatherManager: ObservableObject {
    @Published var ultraSrtNcstInfo: WeatherItem?
    @Published var ultraSrtFcstInfo: WeatherItem?
    @Published var srtFcstInfo: WeatherItem?
    
    func getURL(queryTime: Date, operation: WeatherOperation) -> URL {
        /// e.g.  query time: 11: 25 pm
        /// base time of the data: 11:00 pm
        /// updating time of the data: 11:30 ~ 11:40 pm
        /// should query about data one hour before when the current time is in 0 to 30 min.
        
        // TODO: Get data one hour before if query time is current and there's no data
        /// {"response":{"header":{"resultCode":"01","resultMsg":"APPLICATION_ERROR"}}}
        
        guard let privateKey = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String else {
            fatalError("Cannot find weather API Key")
        }
        let queryTimeString = queryTime.stringDateTime()
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
        urlComponents.path = "/1360000/VilageFcstInfoService_2.0/\(operation.url)"
        urlComponents.queryItems = [serviceKey, numOfRows, pageNo, dataType, base_date, base_time, nx, ny]
        
        // to encode '+' using percent encoding properly
        let characterSet = CharacterSet(charactersIn: "/+").inverted
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.addingPercentEncoding(withAllowedCharacters: characterSet)
        
        guard let url = urlComponents.url else {
            fatalError()
        }
        return url
    }
    
    func fetchData(of queryTime: Date) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let decoder = JSONDecoder()

        for operation in WeatherOperation.allCases {
            switch operation {
                
            case .ultraSrtNcst:
                let time = getBaseTime(operation: .ultraSrtNcst, time: queryTime)
                let url = getURL(queryTime: time, operation: operation)
                
                let task = session.dataTask(with: url) { data, response, error in
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200..<300).contains(httpResponse.statusCode),
                          let data = data else {
                        fatalError()
                    }
                    guard let serviceItems = try? decoder.decode(NcstItemService.self, from: data) else {
                        print("Something went wrong: ultraSrtNcst")
                        return
                    }
                    DispatchQueue.main.async {
                        self.ultraSrtNcstInfo = WeatherItem(operationType: .ultraSrtFcst, from: serviceItems)
                    }
                }
                task.resume()
            case .ultraSrtFcst:
                let time = getBaseTime(operation: .ultraSrtFcst, time: queryTime)
                let url = getURL(queryTime: time, operation: operation)
                
                let task = session.dataTask(with: url) { data, response, error in
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200..<300).contains(httpResponse.statusCode),
                          let data = data else {
                        fatalError()
                    }
                    guard let serviceItems = try? decoder.decode(FcstItemService.self, from: data) else {
                        print("Something went wrong: ultraSrtFcst")
                        return
                    }
                    DispatchQueue.main.async {
                        self.ultraSrtFcstInfo = WeatherItem(operationType: .ultraSrtFcst, from: serviceItems)
                    }
                }
                task.resume()
            case .vilageFcst:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMddHHmm"
                
                let dateTime = queryTime.stringDateTime().0 + "0200"
                
                if let d = dateFormatter.date(from: dateTime) {
                    let url = getURL(queryTime: d, operation: operation)

                    let task = session.dataTask(with: url) { data, response, error in
                        guard let httpResponse = response as? HTTPURLResponse,
                              (200..<300).contains(httpResponse.statusCode),
                              let data = data else {
                            fatalError()
                        }

                        guard let serviceItems = try? decoder.decode(FcstItemService.self, from: data) else {
                            print("Something went wrong: vilageFcst")
                            return
                        }
                        DispatchQueue.main.async {
                            self.srtFcstInfo = WeatherItem(operationType: .vilageFcst, from: serviceItems)
                        }
                    }
                    task.resume()
                }
            }
        }
    }
    
    func getBaseTime(operation:WeatherOperation, time: Date) -> Date {
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
            let baseTimeSet: Set = [2, 5, 8, 11, 14, 17, 20, 23]
            
            var newHours = 0
            if minutes < 10 {
                // newHours would be less and closest value than the current time.
                for h in baseTimeSet {
                    if h >= hours { break }
                    newHours = h
                }
            } else {
                // newHours would be equal or less and closest value than the current time.
                for h in baseTimeSet {
                    if h > hours { break }
                    newHours = h
                }
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMddHHmm"
            let newTimeString = time.stringDateTime().0 + "00" + time.stringDateTime().2
            
            guard var newDate = dateFormatter.date(from: newTimeString) else {
                fatalError("Fail to create a new base time")
            }
            
            newDate.addTimeInterval(TimeInterval(newHours * 3600)) // add hours as much as newHours
            baseTime = newDate
        }
        
        return baseTime
    }
}

extension Date {
    func stringDateTime() -> (String, String, String) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyyMMdd"
        let dateString = formatter.string(from: self)
        
        formatter.dateFormat = "HH"
        let hourString = formatter.string(from: self)

        formatter.dateFormat = "mm"
        let minString = formatter.string(from: self)

        return (dateString, hourString, minString)
    }
    
    var hourBefore: Date {
        Calendar.current.date(byAdding: .hour, value: -1, to: self)!
    }
}
