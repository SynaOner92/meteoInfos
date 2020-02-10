//
//  PrevisionVM.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 09/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation
import UIKit

public class PrevisionVM {
    
    private let prevision: Prevision
    private let previousPrevision: Prevision?
    
    init(prevision: Prevision,
         previousPrevision: Prevision?) {
        self.previousPrevision = previousPrevision
        self.prevision = prevision
    }
    
    var weatherIcon: UIImage? {
        return ImageHelper.getWeatherPictoImage(trendWeather: PrevisionHelper.getTrendWeather(amountRain: prevision.rain,
                                                                                              canSnow: prevision.canSnow))
    }
    
    var temperatureAvailable: Bool {
        return prevision.temperature != nil
    }
    
    var temperature: String? {
        return prevision.temperature?.convertKelvinToDegreeString()
    }
    
    var pressureAvailable: Bool {
        return prevision.pressure != nil
    }
    
    var pressure: String? {
        return prevision.pressure?.convertToPascalString()
    }
    
    var windForceAvailable: Bool {
        return prevision.averageWind != nil
    }
    
    var windForce: String? {
        guard let averageWind = prevision.averageWind else { return "Force et direction du vent : Information indisponible" }
        
        if averageWind == 0 {
            return "Absence de vent"
        } else {
            return "Force et direction du vent : \(averageWind.convertVitesseToString())"
        }
    }
    
    var windIconAvailable: Bool {
        return prevision.windDirection != nil
    }
    
    var windIcon: UIImage? {
        guard let windDirection = prevision.windDirection else { return nil }
        
        let image = UIImage(named: "arrow")
        return image?.rotate(radians: ConversionHelper.degreeToRadius(degree: windDirection%360 - 90))
    }
    
    var trendTemperatureAvailable: Bool {
        prevision.temperature != nil && previousPrevision?.temperature != nil
    }
    
    var trendTemperatureIcon: UIImage? {
        guard let temperature = prevision.temperature,
            let previousTemperature = previousPrevision?.temperature else { return nil }
        
        return getRotatedImage(selectedData: temperature,
                               previousData: previousTemperature)
    }
    
    var trendPressureAvailable: Bool {
        prevision.pressure != nil && previousPrevision?.pressure != nil
    }
    
    var trendPressureIcon: UIImage? {
        guard let pressure = prevision.pressure,
            let previousPressure = previousPrevision?.pressure else { return nil }
        
        return getRotatedImage(selectedData: pressure,
                               previousData: previousPressure)
    }
    
    private func getRotatedImage(selectedData: Double,
                                previousData: Double) -> UIImage? {
        let image = UIImage(named: selectedData == previousData ? "equal" : "arrow")
        return image?.rotate(radians: ConversionHelper.degreeToRadius(degree: selectedData > previousData ? 90 : selectedData == previousData ? 0 : -90))
    }
}
