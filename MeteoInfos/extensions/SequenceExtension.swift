//
//  SequenceExtension.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 07/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation

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
