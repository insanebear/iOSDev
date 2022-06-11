//
//  MyLocation.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/11.
//

import MapKit

final class MyLocation: NSObject, Decodable {
    let name: String
    let image: String
    let detail: String
    var location: CLLocation 
    
    enum CodingKeys: String, CodingKey {
        case name
        case image
        case detail = "description"
        
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        detail = try container.decode(String.self, forKey: .detail)
        
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        
        location = CLLocation(latitude: latitude, longitude: longitude)
    }
}

extension MyLocation: MKAnnotation { // for MyLocation's annotation
    var coordinate: CLLocationCoordinate2D { location.coordinate } // required. Use location value in MyLocation
    var title: String? { name }
}
