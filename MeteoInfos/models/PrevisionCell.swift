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
    @IBOutlet weak var temperaturePrevision: UILabel!
    
    func setup(prevision: Prevision) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        datePrevision.text = dateFormatter.string(from: prevision.date)
        
        if prevision.risqueNeige == "oui" {
            weatherIcon.image = UIImage(named: "snowIcon")
            weatherIcon.setImageColor(color: UIColor.blue)
        } else if let pluie = prevision.pluie {
            
            if pluie > 10.0 {
                weatherIcon.image = UIImage(named: "heavyRainIcon")
            } else if pluie >= 0.1 {
                weatherIcon.image = UIImage(named: "rainIcon")
            } else {
                weatherIcon.image = UIImage(named: "sunIcon")
                weatherIcon.setImageColor(color: UIColor.yellow)
            }
        }
        
        temperaturePrevision.text = prevision.temperature?.convertToDegreeString()
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
