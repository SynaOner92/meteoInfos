//
//  PrevisionMeteo.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 06/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation

struct ApiResponse: Codable {
    let requestState: Int
    var previsions = [Prevision]()
    
    init?(json: [String: Any]) {
        guard
            let requestState = json["request_state"] as? Int
            else { return nil }
        
        self.requestState = requestState

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        for (key, value) in json {
            if let data = value as? [String: Any],
                let date = dateFormatter.date(from: key),
                let prevision = Prevision(json: data, date: date) {
                self.previsions.append(prevision)
            }
        }
    }
}

struct Prevision: Codable {
    let pluie: Double?
    let ventMoyen: Double?
    let risqueNeige: String?
    let temperature: Double?
    let pression: Double?
    let date: Date
    
    init?(json: [String: Any], date: Date) {
        self.date = date
        self.pluie = json["pluie"] as? Double
        self.risqueNeige = json["risque_neige"] as? String
        
        let ventMoyenJson = json["vent_moyen"] as? [String: Any]
        self.ventMoyen = ventMoyenJson?["10m"] as? Double
        
        let temperatureJson = json["temperature"] as? [String: Any]
        self.temperature = temperatureJson?["sol"] as? Double
        
        let pressionJson = json["pression"] as? [String: Any]
        self.pression = pressionJson?["niveau_de_la_mer"] as? Double
    }
}

