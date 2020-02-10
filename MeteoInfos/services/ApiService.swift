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

class ApiService {
        
    static let sharedApiService = ApiService()
    
    private init() { }
    
    private let apiURL = "http://www.infoclimat.fr/public-api/gfs/json"
    
    func getPrevisionsMeteo(location: CLLocationCoordinate2D, completion: @escaping (Result<[DailyPrevisions]>) -> Void) {
        
        debugPrint("Call API with: location.latitude: \(location.latitude), location.longitude: \(location.longitude)")
        let urlToCall = "http://www.infoclimat.fr/public-api/gfs/json?_ll=\(location.latitude),\(location.longitude)&_auth=AxlUQ1YoXH5Sf1tsD3kCK1M7AjcBdwcgBnpRMg5rAH0Bal4%2FVDRUMl8xA34OIQYwBSgHZAswUmIDaFIqCXtTMgNpVDhWPVw7Uj1bPg8gAilTfQJjASEHIAZjUTQOfQBhAWFeJFQ%2FVDJfLgNgDj8GNgUpB3gLNVJvA2hSNQltUzkDZFQzVjJcPFIiWyYPOgJjU2MCMQE%2BB2kGYVEyDjYAYwE0Xj1UM1QxXy4DYA47BjAFPgdnCzBSbgNlUioJe1NJAxNULVZ1XHxSaFt%2FDyICY1M%2BAjY%3D&_c=2628f7cd8d4a81ed1eeb13c822b34207"
        
        Alamofire.request(urlToCall)
            .validate()
            .responseData { response in
                switch response.result {
                    case .failure(let error):
                        debugPrint(error)
                        completion(Result.failure(ApplicationError.alamofireError))
                    case .success(let data):
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let response = ApiResponse(json: json,
                                                          latitude: location.latitude.rounded(toPlaces: 2),
                                                          longitude: location.longitude.rounded(toPlaces: 2)) {
                                if response.requestState == 200 {
                                    let defaults = UserDefaults.standard
                                    defaults.set(try? PropertyListEncoder().encode(response.previsions),
                                                 forKey: defaultsKeys.previsionsKey)
                                    completion(Result.success(response.previsions))
                                } else {
                                    debugPrint(response.requestState)
                                    completion(Result.failure(ApplicationError.not200))
                                }
                            } else {
                                completion(Result.failure(ApplicationError.castFailure))
                            }
                        } else {
                            completion(Result.failure(ApplicationError.castFailure))
                    }
                }
            }
    }
}

