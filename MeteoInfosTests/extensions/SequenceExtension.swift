//
//  SequenceExtension.swift
//  MeteoInfosTests
//
//  Created by Michael Coqueret on 09/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import XCTest
@testable import MeteoInfos

class MeteoInfosSequenceExtensionTests: XCTestCase {
    func testSequenceAverage() {
        let cases = [([1.0, 2.0, 3.0, 4.0], 2.5), ([], nil)]
        cases.forEach {
            XCTAssertEqual($0.0.average(), $0.1)
        }
    }
    
    func testSequenceTotal() {
        let cases = [([1.0, 2.0, 3.0, 4.0], 10.0), ([], 0.0)]
        cases.forEach {
            XCTAssertEqual($0.0.total(), $0.1)
        }
    }
}
