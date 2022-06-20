//
//  ContentView.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button  {
            fetchData()
        } label: {
            Text("Hit me")
        }
    }
}

func getURL() -> URL {
    guard let privateKey = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String else {
        fatalError("Cannot find weather API Key")
    }
    print(privateKey)
    
    let serviceKey = URLQueryItem(name: "serviceKey", value: privateKey)
    let numOfRows = URLQueryItem(name: "numOfRows", value: "100")
    let pageNo = URLQueryItem(name: "pageNo", value: "10")
    let dataType = URLQueryItem(name: "dataType", value: "JSON")
    let base_date = URLQueryItem(name: "base_date", value: "20220620")
    let base_time = URLQueryItem(name: "base_time", value: "0600")
    
    let nx = URLQueryItem(name: "nx", value: "55")
    let ny = URLQueryItem(name: "ny", value: "127")
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "http"
    urlComponents.host = "apis.data.go.kr"
    urlComponents.path = "/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst"
    urlComponents.queryItems = [serviceKey, numOfRows, pageNo, dataType, base_date, base_time, nx, ny]
    
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
        if let result = String(data: data, encoding: .utf8) {
            print(result)
        }
    }
    task.resume()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
