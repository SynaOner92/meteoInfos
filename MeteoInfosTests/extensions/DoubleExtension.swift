//
//  DoubleExtension.swift
//  MeteoInfosTests
//
//  Created by Michael Coqueret on 09/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import XCTest
@testable import MeteoInfos

class MeteoInfosDoubleExtensionTests: XCTestCase {
    func testDoubleConvertVitesseToString() {
        let cases = [(2.0, "2.0 km/h"), (4.15096, "4.15 km/h")]
        cases.forEach {
            XCTAssertEqual($0.0.convertVitesseToString(), $0.1)
        }
    }

    func testDoubleConvertToPascalString() {
        let cases = [(10.0, "10.0 Pa"), (1000.0, "10.0 hPa"), (1000000.0, "1000.0 kPa"), (1000000000.0, "1000.0 MPa")]
        cases.forEach {
            XCTAssertEqual($0.0.convertToPascalString(), $0.1)
        }
    }

    func testDoubleConvertKelvinToDegreeString() {
        let cases = [(288.15, "15.0°C"), (0.0, "-273.2°C")]
        cases.forEach {
            XCTAssertEqual($0.0.convertKelvinToDegreeString(), $0.1)
        }
    }

    func testDoubleRounded() {
        let cases = [(288.15149595920, 2, 288.15), (288.15149595920, 4, 288.1515), (288.15149595920, 6, 288.151496)]
        cases.forEach {
            XCTAssertEqual($0.0.rounded(toPlaces: $0.1), $0.2)
        }
    }
}
