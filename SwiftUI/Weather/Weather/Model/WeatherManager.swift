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
        
        let dateString = queryTime.stringDateTime().0
        let timeString = queryTime.stringDateTime().1

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
                let url = getURL(queryTime: queryTime, operation: operation)
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
                let url = getURL(queryTime: queryTime, operation: operation)
                
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
}

extension Date {
    func stringDateTime() -> (String, String) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyyMMdd"
        let dateString = formatter.string(from: self)
        
        formatter.dateFormat = "HHmm"
        let timeString = formatter.string(from: self)

        return (dateString, timeString)
    }
    
    var hourBefore: Date {
        Calendar.current.date(byAdding: .hour, value: -1, to: self)!
    }
}
