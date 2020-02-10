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
    @IBOutlet weak private var datePrevision: UILabel!
    @IBOutlet weak private var weatherIcon: UIImageView!
    @IBOutlet weak private var minTempLabel: UILabel!
    @IBOutlet weak private var maxTempLabel: UILabel!
    @IBOutlet weak private var amountRainLabel: UILabel!
    @IBOutlet weak private var averageWindLabel: UILabel!
    
    // MARK: Init
    func setup(withPrevisionCellVM previsionCellVM: PrevisionCellVM) {
        
        datePrevision.text = previsionCellVM.date
        
        minTempLabel.text = previsionCellVM.minTemperatureAvailable ? previsionCellVM.minTemperature : previsionCellVM.averageTemperature
        maxTempLabel.text = previsionCellVM.maxTemperature
        maxTempLabel.isHidden = !previsionCellVM.minTemperatureAvailable
        
        amountRainLabel.text = previsionCellVM.amountRain
        
        weatherIcon.image = previsionCellVM.weatherIcon
        
        averageWindLabel.text = previsionCellVM.averageWind
        averageWindLabel.isHidden = !previsionCellVM.averageWindAvailable
    }
}

