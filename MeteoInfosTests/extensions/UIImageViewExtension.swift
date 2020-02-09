//
//  UIImageViewExtension.swift
//  MeteoInfosTests
//
//  Created by Michael Coqueret on 09/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import XCTest
@testable import MeteoInfos

class MeteoInfosUIImageViewExtensionTests: XCTestCase {

    func testSetImageColor() {
        let cases = [(UIColor.black), (UIColor.white)]
        cases.forEach {
            let imageView = UIImageView()
            imageView.setImageColor(color: $0)
            XCTAssertEqual(imageView.tintColor, $0)
        }
    }
}
