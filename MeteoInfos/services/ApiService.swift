//
//  APIHandler.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 06/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation
import Alamofire



protocol ApiServiceProtocol {
    func getPrevisionsMeteo(
        completion: @escaping ([Prevision]) -> Void
    )
}

class ApiService: ApiServiceProtocol {
        
    static let sharedApiService = ApiService()
    
    private let apiURL = "http://www.infoclimat.fr/public-api/gfs/json"
    
    func getPrevisionsMeteo(completion: @escaping ([Prevision]) -> Void) {
        
        let urlToCall = "http://www.infoclimat.fr/public-api/gfs/json?_ll=48.85341,2.3488&_auth=AxlUQ1YoXH5Sf1tsD3kCK1M7AjcBdwcgBnpRMg5rAH0Bal4%2FVDRUMl8xA34OIQYwBSgHZAswUmIDaFIqCXtTMgNpVDhWPVw7Uj1bPg8gAilTfQJjASEHIAZjUTQOfQBhAWFeJFQ%2FVDJfLgNgDj8GNgUpB3gLNVJvA2hSNQltUzkDZFQzVjJcPFIiWyYPOgJjU2MCMQE%2BB2kGYVEyDjYAYwE0Xj1UM1QxXy4DYA47BjAFPgdnCzBSbgNlUioJe1NJAxNULVZ1XHxSaFt%2FDyICY1M%2BAjY%3D&_c=2628f7cd8d4a81ed1eeb13c822b34207"
        
        let parameters =
        [
            "_ll": "48.85341,2.3488",
            "_auth": "AxlUQ1YoXH5Sf1tsD3kCK1M7AjcBdwcgBnpRMg5rAH0Bal4%2FVDRUMl8xA34OIQYwBSgHZAswUmIDaFIqCXtTMgNpVDhWPVw7Uj1bPg8gAilTfQJjASEHIAZjUTQOfQBhAWFeJFQ%2FVDJfLgNgDj8GNgUpB3gLNVJvA2hSNQltUzkDZFQzVjJcPFIiWyYPOgJjU2MCMQE%2BB2kGYVEyDjYAYwE0Xj1UM1QxXy4DYA47BjAFPgdnCzBSbgNlUioJe1NJAxNULVZ1XHxSaFt%2FDyICY1M%2BAjY%3D",
            "_c": "2628f7cd8d4a81ed1eeb13c822b34207"
        ]
        
//        Alamofire.request(apiURL,
//                          method: .get,
//                          parameters: parameters)
        Alamofire.request(urlToCall)
            .validate()
            .responseData { response in
                
                switch response.result {
                    case .failure(let error):
                        print("todo \(error)")
                    case .success(let data):
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let response = ApiResponse(json: json) {
                                
                                
                                completion(response.previsions.sorted(by: { $0.date < $1.date }))
                            }
                            
                            // TODO else
                        }
                }
            }
    }
}
