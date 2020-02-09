//
//  ApplicationError.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 09/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation

enum ApplicationError: Error {
    case alamofireError
    case not200
    case castFailure
}
