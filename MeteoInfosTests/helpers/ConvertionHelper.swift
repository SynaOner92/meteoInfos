//
//  ConvertionHelper.swift
//  MeteoInfosTests
//
//  Created by Michael Coqueret on 09/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import XCTest
@testable import MeteoInfos

class MeteoInfosConversionHelperTests: XCTestCase {
    func testConvertKelvinToDegree() {
        let cases = [(288.15, 15.0), (0.0, -273.15)]
        cases.forEach {
            XCTAssertEqual(ConversionHelper.kelvinToDegree(kelvin: $0.0), $0.1)
        }
    }
    
    func testDegreeToRadius() {
        let cases = [(0, Float(0.0)), (10, Float(0.17453292))]
        cases.forEach {
            XCTAssertEqual(ConversionHelper.degreeToRadius(degree: $0.0), $0.1)
        }
    }
}
