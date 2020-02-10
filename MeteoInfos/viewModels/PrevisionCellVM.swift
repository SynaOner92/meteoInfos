//
//  PrevisionCellModel.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 09/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation
import UIKit

class PrevisionCellVM {
    
    private let dailyPrevisions: DailyPrevisions
    
    init(dailyPrevisions: DailyPrevisions) {
        self.dailyPrevisions = dailyPrevisions
    }
    
    var date: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "FR-fr")
        if let date = dailyPrevisions.date {
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    var minTemperatureAvailable: Bool {
        return dailyPrevisions.minTemperature != nil && dailyPrevisions.minTemperature != dailyPrevisions.maxTemperature
    }
    
    var minTemperature: String? {
        guard let minTemp = dailyPrevisions.minTemperature,
            let maxTemp = dailyPrevisions.maxTemperature else { return nil }
        
        if minTemp == maxTemp {
            return nil
        }
        return "Min. : \(minTemp.convertKelvinToDegreeString())"
    }
    
    var maxTemperature: String? {
        guard let minTemp = dailyPrevisions.minTemperature,
                let maxTemp = dailyPrevisions.maxTemperature else { return nil }
            
            if minTemp == maxTemp {
                return nil
            }
            return "Max. : \(maxTemp.convertKelvinToDegreeString())"
    }

    var averageTemperature: String? {
        guard let minTemp = dailyPrevisions.minTemperature else { return nil }
        
        return "Moy : \(minTemp.convertKelvinToDegreeString())"
    }
    
    var amountRain: String {
        return "Précipitations : \(dailyPrevisions.amountRain.rounded(toPlaces: 2))mm"
    }

    var weatherIcon: UIImage? {
        return ImageHelper.getWeatherPictoImage(trendWeather: PrevisionHelper.getTrendWeather(amountRain: dailyPrevisions.amountRain,
                                                                                              canSnow: dailyPrevisions.canSnow))
    }
    
    var averageWindAvailable: Bool {
        return dailyPrevisions.averageWind != nil
    }
    
    var averageWind: String? {
        guard let averageWind = dailyPrevisions.averageWind else { return nil }
        
        return "Vit. du vent : \(averageWind.convertVitesseToString())"
    }
    
}
