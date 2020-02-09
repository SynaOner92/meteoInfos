//
//  PrevisionHelper.swift
//  MeteoInfosTests
//
//  Created by Michael Coqueret on 09/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import XCTest
@testable import MeteoInfos

class MeteoInfosPrevisionHelperTests: XCTestCase {
    func testgetTrendWeather() {
        let cases = [(0.0, false, WeatherType.sunny), (0.0, true, WeatherType.snow), (100.0, false, WeatherType.rain), (1000.0, false, WeatherType.heavyRain), (1.0, false, WeatherType.weakRain)]
        cases.forEach {
            XCTAssertEqual(PrevisionHelper.getTrendWeather(amountRain: $0.0, canSnow: $0.1), $0.2)
        }
    }
}
