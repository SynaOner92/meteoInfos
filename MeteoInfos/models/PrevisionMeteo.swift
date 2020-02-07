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
    
    var previsions = [DailyPrevisions]()
    
    init?(json: [String: Any]) {
        guard
            let requestState = json["request_state"] as? Int
            else { return nil }
        
        self.requestState = requestState

        let dateFormatter = DateFormatter()

        var previsionsTemp = [String: [Prevision]]()
        for (key, value) in json {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let data = value as? [String: Any],
                let date = dateFormatter.date(from: key),
                let prevision = Prevision(json: data, date: date) {
                
                
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateString = dateFormatter.string(from: date)
            
                if previsionsTemp.contains(where: { $0.key == dateString }) {
                    previsionsTemp[dateString]?.append(prevision)
                } else {
                    previsionsTemp[dateString] = [prevision]
                }
            }
        }
        
        let sortedPrevisions = sortPrevisions(previsions: previsionsTemp)
        
        sortedPrevisions.forEach {
            previsions.append(DailyPrevisions(previsions: $0.value))
        }
        
    }
}

private func sortPrevisions(previsions: [String: [Prevision]]) -> [(key: String, value: [Prevision])] {
    var sortedPrevisions = [String: [Prevision]]()
    for (key, value) in previsions {
        sortedPrevisions[key] = value.sorted(by: { $0.date < $1.date })
    }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return sortedPrevisions.sorted(by: { dateFormatter.date(from: $0.0)! < dateFormatter.date(from: $1.0)! })
}

enum WeatherType {
    case sunny
    case snow
    case rain
    case weakRain
    case heavyRain
}

struct DailyPrevisions: Codable {
    let previsions: [Prevision]
    
    var trendWeather: WeatherType {
        get {
            if self.amountRain/24 > 8 {
                return .heavyRain
            } else if self.amountRain/24 >= 4 {
                return .rain
            } else if self.amountRain/24 > 0 {
                return .weakRain
            } else if self.canSnow {
                return .snow
            } else {
                return .sunny
            }
        }
    }
    
    var date: Date? {
        get {
            return previsions.first?.date
        }
    }
    
    var maxTemperature: Double? {
        get {
            return previsions.compactMap{ $0.temperature }.min()
        }
    }
    
    var minTemperature: Double? {
        get {
            return previsions.compactMap{ $0.temperature }.max()
        }
    }
    
    var averageTemperature: Double? {
       get {
           return previsions.compactMap{ $0.temperature }.average()
       }
    }
    
    var averageWind: Double? {
        get {
            return previsions.compactMap{ $0.ventMoyen }.average()
        }
    }
    
    var minWind: Double? {
        get {
            return previsions.compactMap{ $0.ventMoyen }.min()
        }
    }
    
    var maxWind: Double? {
        get {
            return previsions.compactMap{ $0.ventMoyen }.max()
        }
    }
      
    var amountRain: Double {
        get {
            return previsions.compactMap{ $0.pluie }.total()
        }
    }
    
    var canSnow: Bool {
        get {
            return previsions.compactMap{ $0.risqueNeige }.contains("oui")
        }
    }

}

extension Sequence where Element: BinaryFloatingPoint {
    func average() -> Element? {
        var i: Element = 0
        var total: Element = 0

        for value in self {
            total = total + value
            i += 1
        }

        return i == 0 ? nil : total / i
    }
    
    func total() -> Element {
        var total: Element = 0
        
        for value in self {
            total = total + value
        }
        
        return total
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
