//
//  ImageQuery.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/08/16.
//

import Foundation

class ImageQuery {
    func fetchData(query: String, completion: @escaping ([Image]) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let url = getURL(query: query)
        var request = URLRequest(url: url)

        guard let privateKey = Bundle.main.object(forInfoDictionaryKey: "UNSPLASH_API_KEY") as? String else {
            fatalError("Cannot find API Key")
        }
        request.addValue("Client-ID \(privateKey)", forHTTPHeaderField: "Authorization")

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
        let query = URLQueryItem(name: "query", value: query)

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = "/search/photos"
        urlComponents.queryItems = [query]

        guard let url = urlComponents.url else {
            fatalError("Cannot reach to Unsplash API")
        }
        return url
    }
    
    func parseJSON(data: Data) -> [Image] {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(ImageData.self, from: data)
            return response.results
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return []
    }
}
