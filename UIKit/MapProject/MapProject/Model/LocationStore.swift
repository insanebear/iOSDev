//
//  LocationStore.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/11.
//

import Foundation

struct LocationStore {
    let myLocations: [MyLocation] = {
        guard let json = Bundle.main.url(forResource: "LocationData", withExtension: ".json") else {
            fatalError("Cannot find 'LocationData.json' file")
        }
        
        do {
            let jsonData = try Data(contentsOf: json)
            return try JSONDecoder().decode([MyLocation].self, from: jsonData)
        } catch {
            fatalError("Cannot parse 'LocationData.json' file")
        }
    } ()
}
