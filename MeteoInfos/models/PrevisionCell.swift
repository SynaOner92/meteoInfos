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
    
    @IBOutlet weak var datePrevision: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var amountRainLabel: UILabel!
    @IBOutlet weak var averageWindLabel: UILabel!
    
    func setup(prevision: DailyPrevisions) {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        if let date = prevision.date {
            datePrevision.text = dateFormatter.string(from: date)
        }
        
        if let minTemp = prevision.minTemperature?.convertToDegreeString(),
            let maxTemp = prevision.maxTemperature?.convertToDegreeString() {
            if minTemp == maxTemp {
                let averageTemp = prevision.averageTemperature!.convertToDegreeString()
                minTempLabel.text = "Moy : \(averageTemp)"
                maxTempLabel.isHidden = true
            } else {
                maxTempLabel.isHidden = false
                minTempLabel.text = "Min : \(minTemp)"
                maxTempLabel.text = "Max : \(maxTemp)"
            }
        }
        
        amountRainLabel.text = "Précipitations : \(prevision.amountRain.rounded(toPlaces: 2))mm"
        
        switch prevision.trendWeather {
        case .heavyRain:
            weatherIcon.image = UIImage(named: "heavyRainIcon")
        case .rain:
            weatherIcon.image = UIImage(named: "rainIcon")
        case .snow:
            weatherIcon.image = UIImage(named: "snowIcon")
        case .sunny:
            weatherIcon.image = UIImage(named: "sunIcon")
        case .weakRain:
            weatherIcon.image = UIImage(named: "weakRainIcon")
        }
        
        if let averageWind = prevision.averageWind {
            averageWindLabel.text = "Vit. du vent : \(Int(averageWind.rounded())) km/h"
        } else {
            averageWindLabel.text = "Pas de vent prévu"
        }
        
    }
}

extension Double {
    func convertToDegreeString() -> String {
        return "\((self - 273.5).rounded(toPlaces: 1))°C"
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
