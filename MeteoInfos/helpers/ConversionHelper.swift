//
//  ConversionHelper.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 07/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation

class ConversionHelper {
    
    static func kelvinToDegree(kelvin: Double) -> Double {
        return kelvin - 273.5
    }
    
    static func degreeToRadius(degree: Int) -> Float {
        return Float(degree) * 0.01745329252
    }
}
