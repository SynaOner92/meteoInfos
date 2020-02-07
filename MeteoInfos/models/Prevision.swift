//
//  Prevision.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 08/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation

struct Prevision: Codable {
    let rain: Double
    let averageWind: Double?
    let windDirection: Int?
    let canSnow: Bool
    let temperature: Double?
    let pressure: Double?
    let date: Date
    
    var dateDisplay: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        }
    }
    
    init?(json: [String: Any], date: Date) {
        self.date = date
        self.rain = json["pluie"] as? Double ?? 0
        
        let canSnow = json["risque_neige"] as? String
        self.canSnow = canSnow == "oui"
        
        let ventMoyenJson = json["vent_moyen"] as? [String: Any]
        self.averageWind = ventMoyenJson?["10m"] as? Double
        
        let ventDirectionJson = json["vent_direction"] as? [String: Any]
        self.windDirection = ventDirectionJson?["10m"] as? Int
        
        let temperatureJson = json["temperature"] as? [String: Any]
        self.temperature = temperatureJson?["sol"] as? Double
        
        let pressionJson = json["pression"] as? [String: Any]
        self.pressure = pressionJson?["niveau_de_la_mer"] as? Double
    }
}
