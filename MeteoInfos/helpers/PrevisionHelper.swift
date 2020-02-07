//
//  PrevisionHelper.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 07/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation

class PrevisionHelper {
    
    static func getTrendWeather(amountRain: Double, canSnow: Bool) -> WeatherType {
        if amountRain/24 > 8 {
            return .heavyRain
        } else if amountRain/24 >= 4 {
            return .rain
        } else if amountRain/24 > 0 {
            return .weakRain
        } else if canSnow {
            return .snow
        } else {
            return .sunny
        }
    }
}
