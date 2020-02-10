//
//  PrevisionView.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 09/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class PrevisionView: UIView {

    @IBOutlet weak private var weatherTrendIcon: UIImageView!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var temperatureTrendView: UIView!
    @IBOutlet weak private var temperatureIcon: UIImageView!
    @IBOutlet weak private var pressureLabel: UILabel!
    @IBOutlet weak private var pressureTrendView: UIView!
    @IBOutlet weak private var pressureIcon: UIImageView!
    @IBOutlet weak private var windLabel: UILabel!
    @IBOutlet weak private var windIcon: UIImageView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: PrevisionView.self)
        if let viewsToAdd = bundle.loadNibNamed("PrevisionView", owner: self, options: nil),
            let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
    }
    
    func configure(withPrevisionVM previsionVM: PrevisionVM) {

        weatherTrendIcon.image = previsionVM.weatherIcon

        temperatureLabel.text = previsionVM.temperature
        temperatureLabel.isHidden = !previsionVM.temperatureAvailable

        temperatureIcon.image = previsionVM.trendTemperatureIcon
        temperatureTrendView.isHidden = !previsionVM.trendTemperatureAvailable

        pressureLabel.text = previsionVM.pressure
        pressureLabel.isHidden = !previsionVM.pressureAvailable
        
        pressureIcon.image = previsionVM.trendPressureIcon
        pressureTrendView.isHidden = !previsionVM.trendPressureAvailable

        windLabel.text = previsionVM.windForce
        windLabel.isHidden = !previsionVM.windForceAvailable

        windIcon.image = previsionVM.windIcon
        windIcon.isHidden = !previsionVM.windIconAvailable

    }
}

