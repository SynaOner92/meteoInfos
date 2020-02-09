//
//  PrevisionCellModel.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 09/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation
import UIKit

class PrevisionCellViewModel {
    
    private let dailyPrevision: DailyPrevisions
    
    init(dailyPrevision: DailyPrevisions) {
        self.dailyPrevision = dailyPrevision
    }
    
    var date: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "FR-fr")
        if let date = dailyPrevision.date {
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    var minTemperatureAvailable: Bool {
        return dailyPrevision.minTemperature != nil && dailyPrevision.minTemperature != dailyPrevision.maxTemperature
    }
    
    var minTemperature: String? {
        guard let minTemp = dailyPrevision.minTemperature,
            let maxTemp = dailyPrevision.maxTemperature else { return nil }
        
        if minTemp == maxTemp {
            return nil
        }
        return "Min. : \(minTemp.convertKelvinToDegreeString())"
    }
    
    var maxTemperature: String? {
        guard let minTemp = dailyPrevision.minTemperature,
                let maxTemp = dailyPrevision.maxTemperature else { return nil }
            
            if minTemp == maxTemp {
                return nil
            }
            return "Max. : \(maxTemp.convertKelvinToDegreeString())"
    }

    var averageTemperature: String? {
        guard let minTemp = dailyPrevision.minTemperature else { return nil }
        
        return "Moy : \(minTemp.convertKelvinToDegreeString())"
    }
    
    var amountRain: String {
        return "Précipitations : \(dailyPrevision.amountRain.rounded(toPlaces: 2))mm"
    }

    var weatherIcon: UIImage? {
        return ImageHelper.getWeatherPictoImage(trendWeather: PrevisionHelper.getTrendWeather(amountRain: dailyPrevision.amountRain,
                                                                                              canSnow: dailyPrevision.canSnow))
    }
    
    var averageWindAvailable: Bool {
        return dailyPrevision.averageWind != nil
    }
    
    var averageWind: String? {
        guard let averageWind = dailyPrevision.averageWind else { return nil }
        
        return "Vit. du vent : \(averageWind.convertVitesseToString())"
    }
    
    
}
