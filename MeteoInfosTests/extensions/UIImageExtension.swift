//
//  UIImageExtension.swift
//  MeteoInfosTests
//
//  Created by Michael Coqueret on 09/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import XCTest
import UIKit
import Foundation
@testable import MeteoInfos

class MeteoInfosUIImageExtensionTests: XCTestCase {

    func testRotate() {
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        imageView.image = UIImage(named:"arrow")
        
        XCTAssertEqual(imageView.bounds.height, 200.0)
        XCTAssertEqual(imageView.bounds.width, 100.0)
        
        
        let cases = [(UIColor.black), (UIColor.white)]
        cases.forEach {
            let imageView = UIImageView()
            imageView.setImageColor(color: $0)
            XCTAssertEqual(imageView.tintColor, $0)
        }
    }
}
