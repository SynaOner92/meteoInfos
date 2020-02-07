//
//  ImageHelper.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 07/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    
    static func getWeatherPictoImage(trendWeather: WeatherType) -> UIImage? {
        switch trendWeather {
        case .heavyRain:
            return UIImage(named: "heavyRainIcon")
        case .rain:
            return UIImage(named: "rainIcon")
        case .snow:
            return UIImage(named: "snowIcon")
        case .sunny:
            return UIImage(named: "sunIcon")
        case .weakRain:
            return UIImage(named: "weakRainIcon")
        }
    }
}
