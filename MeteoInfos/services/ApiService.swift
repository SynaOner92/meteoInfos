//
//  APIHandler.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 06/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation


protocol ApiServiceProtocol {
    func getPrevisionsMeteo(
        location: CLLocationCoordinate2D,
        completion: @escaping ([Prevision]) -> Void
    )
}

class ApiService: ApiServiceProtocol {
        
    static let sharedApiService = ApiService()
    
    private init() { }
    
    private let apiURL = "http://www.infoclimat.fr/public-api/gfs/json"
    
    func getPrevisionsMeteo(location: CLLocationCoordinate2D, completion: @escaping ([Prevision]) -> Void) {
        
        print("location.latitude: \(location.latitude)")
        print("location.longitude: \(location.longitude)")
        let urlToCall = "http://www.infoclimat.fr/public-api/gfs/json?_ll=\(location.latitude),\(location.longitude)&_auth=AxlUQ1YoXH5Sf1tsD3kCK1M7AjcBdwcgBnpRMg5rAH0Bal4%2FVDRUMl8xA34OIQYwBSgHZAswUmIDaFIqCXtTMgNpVDhWPVw7Uj1bPg8gAilTfQJjASEHIAZjUTQOfQBhAWFeJFQ%2FVDJfLgNgDj8GNgUpB3gLNVJvA2hSNQltUzkDZFQzVjJcPFIiWyYPOgJjU2MCMQE%2BB2kGYVEyDjYAYwE0Xj1UM1QxXy4DYA47BjAFPgdnCzBSbgNlUioJe1NJAxNULVZ1XHxSaFt%2FDyICY1M%2BAjY%3D&_c=2628f7cd8d4a81ed1eeb13c822b34207"
        
        Alamofire.request(urlToCall)
            .validate()
            .responseData { response in
                
                switch response.result {
                    case .failure(let error):
                        print("todo \(error)")
                    case .success(let data):

                        let defaults = UserDefaults.standard
                        defaults.set(data, forKey: defaultsKeys.previsionsKey)
                        
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let response = ApiResponse(json: json) {
                                
                                let sortedPrevisions = response.previsions.sorted(by: { $0.date < $1.date })
                                
                                
                                completion(sortedPrevisions)
                            }
                        }
                }
            }
    }
}
