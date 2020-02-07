//
//  DoubleExtension.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 07/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation

extension Double {
    func convertVitesseToString() -> String {
        return "\(self.rounded(toPlaces: 2)) km/h"
    }
    
    func convertKelvinToDegreeString() -> String {
        return "\(ConversionHelper.kelvinToDegree(kelvin: self).rounded(toPlaces: 1))°C"
    }
    
    func convertToPascalString() -> String {
        if self > 1000000 {
            return "\(self/1000000) MPa"
        } else if self > 1000 {
            return "\(self/1000) kPa"
        } else if self > 100 {
            return "\(self/100) hPa"
        } else {
            return "\(self) Pa"
        }
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
