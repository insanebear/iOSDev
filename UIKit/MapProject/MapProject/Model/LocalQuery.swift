//
//  LocalQuery.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/14.
//

import Foundation

class LocalQuery {
    func searchData(query: String, completion: @escaping ([LocalData]) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let url = getURL(query: query)
        var request = URLRequest(url: url)
        
        guard let privateKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_LOCAL_API_KEY") as? String else {
            fatalError("Cannot find API Key")
        }
        request.addValue("KakaoAK \(privateKey)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No http response")
                return
            }
            guard (200..<300).contains(httpResponse.statusCode) else {
                print(httpResponse.statusCode)
                return
            }
            guard let data = data else {
                fatalError()
            }
            
            let searchResults = self.parseJSON(data: data)
            completion(searchResults)
        }
        task.resume()
    }
    
    func getURL(query: String) -> URL {
        let queryItem = URLQueryItem(name: "query", value: query)

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "dapi.kakao.com"
        urlComponents.path = "/v2/local/search/keyword.json"
        urlComponents.queryItems = [queryItem]
        
        guard let url = urlComponents.url else {
            fatalError("Cannot reach Kakao Local API")
        }
        return url
    }
    
    func parseJSON(data: Data) -> [LocalData] {
        let decoder = JSONDecoder()
        
        guard let response = try? decoder.decode(LocalSearchData.self, from: data) else {
            print("Something went wong")
            return []
        }
        return response.documents
    }
}
