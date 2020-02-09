//
//  PrevisionMeteo.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 06/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation

struct DailyPrevisions: Codable {
    let previsions: [Prevision]
    
    var numberOfPrevision: Int { return previsions.count }
    var date: Date? { return previsions.first?.date }
    var maxTemperature: Double? { return previsions.compactMap{ $0.temperature }.max() }
    var minTemperature: Double? { return previsions.compactMap{ $0.temperature }.min() }
    var averageTemperature: Double? { return previsions.compactMap{ $0.temperature }.average() }
    var averageWind: Double? { return previsions.compactMap{ $0.averageWind }.average() }
    var minWind: Double? { return previsions.compactMap{ $0.averageWind }.min() }
    var maxWind: Double? { return previsions.compactMap{ $0.averageWind }.max() }
    var amountRain: Double { return previsions.compactMap{ $0.rain }.total() }
    var canSnow: Bool { return previsions.contains(where: { $0.canSnow }) }
}
