//
//  ApiResponse.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 08/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation

struct ApiResponse: Codable {
    let requestState: Int
    var previsions = [DailyPrevisions]()
    
    init?(json: [String: Any], latitude: Double, longitude: Double) {
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
        
        sortPrevisions(previsions: previsionsTemp).forEach {
            previsions.append(DailyPrevisions(previsions: $0.value, latitude: latitude, longitude: longitude))
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
}

