//
//  WeatherManager+Converter.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/30.
//

import CoreLocation

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
        
        let x = ra * sin(theta) + constants.xo + 1.5
        let y = (ro - ra * cos(theta)) + constants.yo + 1.5
        
        return (Int(x), Int(y))
    }
}
