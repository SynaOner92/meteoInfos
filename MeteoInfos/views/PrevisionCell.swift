//
//  PrevisionCell.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 06/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation
import UIKit

class PrevisionCell: UITableViewCell {
    
    // MARK: IBOutlet
    @IBOutlet weak var datePrevision: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var amountRainLabel: UILabel!
    @IBOutlet weak var averageWindLabel: UILabel!
    
    // MARK: Init
    func setup(prevision: DailyPrevisions) {
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        if let date = prevision.date {
            datePrevision.text = dateFormatter.string(from: date)
        }
        
        if let minTemp = prevision.minTemperature?.convertKelvinToDegreeString(),
            let maxTemp = prevision.maxTemperature?.convertKelvinToDegreeString() {
            if minTemp == maxTemp {
                let averageTemp = prevision.averageTemperature!.convertKelvinToDegreeString()
                minTempLabel.text = "Moy : \(averageTemp)"
                maxTempLabel.isHidden = true
            } else {
                maxTempLabel.isHidden = false
                minTempLabel.text = "Min. : \(minTemp)"
                maxTempLabel.text = "Max. : \(maxTemp)"
            }
        }
        
        amountRainLabel.text = "Précipitations : \(prevision.amountRain.rounded(toPlaces: 2))mm"
        
        weatherIcon.image = ImageHelper.getWeatherPictoImage(trendWeather: PrevisionHelper.getTrendWeather(amountRain: prevision.amountRain,
                                                                                                           canSnow: prevision.canSnow))
        
        if let averageWind = prevision.averageWind {
            averageWindLabel.text = "Vit. du vent : \(averageWind.convertVitesseToString())"
        } else {
            averageWindLabel.text = "Pas de vent prévu"
        }
        
    }
}

