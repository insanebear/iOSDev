//
//  WeatherData+Enum.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/23.
//

import Foundation

enum WeatherOperation: CaseIterable {
    case ultraSrtNcst
    case ultraSrtFcst
    case vilageFcst
//    case fcstVersion
    
    var description: String {
        switch (self) {
        case .ultraSrtNcst:
            return "초단기실황조회"
        case .ultraSrtFcst:
            return "초단기예보조회"
        case .vilageFcst:
            return "단기예보조회"
//        case .fcstVersion:
//            return "예보버전조회"
        }
    }
    var urlPath: String {
        switch (self){
        case .ultraSrtNcst:
            return "getUltraSrtNcst"
        case .ultraSrtFcst:
            return "getUltraSrtFcst"
        case .vilageFcst:
            return "getVilageFcst"
//        case .fcstVersion:
//            return "getFcstVersion"
        }
    }
}
