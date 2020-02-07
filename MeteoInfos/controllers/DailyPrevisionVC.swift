//
//  DailyPrevisionVC.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 07/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation
import UIKit

class DailyPrevisionVC: UIViewController {

    var dailyPrevision: DailyPrevisions?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let date = dailyPrevision?.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMMM yyyy"
            dateFormatter.locale = Locale(identifier: "FR-fr")
            self.title = "Prévisions du \(dateFormatter.string(from: date))"
        } else {
            dismiss(animated: true, completion: nil)
        }
    
    }
    
}
