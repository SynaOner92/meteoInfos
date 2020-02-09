//
//  PrevisionCell.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 06/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation
import UIKit

class PrevisionCell: UITableViewCell {
    
    // MARK: IBOutlet
    @IBOutlet weak var datePrevision: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var amountRainLabel: UILabel!
    @IBOutlet weak var averageWindLabel: UILabel!
    
    // MARK: Init
    func setup(withPrevisionCellViewModel previsionCellViewModel: PrevisionCellViewModel) {
        
        datePrevision.text = previsionCellViewModel.date
        
        minTempLabel.text = previsionCellViewModel.minTemperatureAvailable ? previsionCellViewModel.minTemperature : previsionCellViewModel.averageTemperature
        maxTempLabel.text = previsionCellViewModel.maxTemperature
        maxTempLabel.isHidden = !previsionCellViewModel.minTemperatureAvailable
        
        amountRainLabel.text = previsionCellViewModel.amountRain
        
        weatherIcon.image = previsionCellViewModel.weatherIcon
        
        averageWindLabel.text = previsionCellViewModel.averageWind
        averageWindLabel.isHidden = !previsionCellViewModel.averageWindAvailable
    }
}

