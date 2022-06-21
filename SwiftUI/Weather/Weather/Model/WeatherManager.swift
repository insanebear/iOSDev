//
//  WeatherManager.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import Foundation

class WeatherManager: ObservableObject {
    @Published var weatherInfo: NcstItem?
    
    func getURL() -> URL {
        guard let privateKey = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String else {
            fatalError("Cannot find weather API Key")
        }
        
        let serviceKey = URLQueryItem(name: "serviceKey", value: privateKey)
        let numOfRows = URLQueryItem(name: "numOfRows", value: "100")
        let pageNo = URLQueryItem(name: "pageNo", value: "10")
        let dataType = URLQueryItem(name: "dataType", value: "JSON")
        let base_date = URLQueryItem(name: "base_date", value: "20220621")
        let base_time = URLQueryItem(name: "base_time", value: "0600")
        
        let nx = URLQueryItem(name: "nx", value: "55")
        let ny = URLQueryItem(name: "ny", value: "127")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "apis.data.go.kr"
        urlComponents.path = "/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst"
        urlComponents.queryItems = [serviceKey, numOfRows, pageNo, dataType, base_date, base_time, nx, ny]
        
        // to encode '+' using percent encoding properly
        let characterSet = CharacterSet(charactersIn: "/+").inverted
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.addingPercentEncoding(withAllowedCharacters: characterSet)
        
        guard let url = urlComponents.url else {
            fatalError()
        }
        return url
    }

    func fetchData() {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let url = getURL()
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode),
                  let data = data else {
                      fatalError()
                  }
//            if let result = String(data: data, encoding: .utf8) {
//                print(result)
//            }
            
            let decoder = JSONDecoder()
            
            guard let serviceItems = try? decoder.decode(NcstItemService.self, from: data) else {
                print("Something went wrong")
                return
            }
            DispatchQueue.main.async {
                self.weatherInfo = NcstItem(from: serviceItems)
            }
        }
        task.resume()
    }
}
