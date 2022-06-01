//
//  MusicQuery.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/06/01.
//

import Foundation

class MusicQuery {
    func getURL(term: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "itunes.apple.com"
        urlComponents.path = "/search"

        let media = URLQueryItem(name: "media", value: "music")
        let entity = URLQueryItem(name: "entity", value: "song")
        let term = URLQueryItem(name: "term", value: "\(term)")
        let limit = URLQueryItem(name: "limit", value: "200")

        urlComponents.queryItems = [media, entity, term, limit]

        guard let url = urlComponents.url else {
            fatalError()
        }
        
        return url
    }
    
    func searchMusic(searchTerm: String, completion: @escaping ([Song]) -> Void) {
        let url = getURL(term: searchTerm)
        let request = URLRequest(url: url)
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)

        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No http response")
                return
            }
            guard (200..<300).contains(httpResponse.statusCode) else {
                print("ResponseCode \(httpResponse.statusCode)")
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
    
    func parseJSON(data: Data) -> [Song] {
        let decoder = JSONDecoder()
        
        guard let response = try? decoder.decode(SearchResponse.self, from: data) else {
            print("Something went wrong")
            return []
        }
        return response.results
    }
}
