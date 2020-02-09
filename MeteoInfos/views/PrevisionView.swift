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

    @IBOutlet weak var weatherTrendIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureTrendView: UIView!
    @IBOutlet weak var temperatureIcon: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var pressureTrendView: UIView!
    @IBOutlet weak var pressureIcon: UIImageView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var windIcon: UIImageView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }
    
    func commonInit() {
        let bundle = Bundle.init(for: PrevisionView.self)
        if let viewsToAdd = bundle.loadNibNamed("PrevisionView", owner: self, options: nil),
            let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
    }
    
    func configure(withPrevisionViewModel previsionViewModel: PrevisionViewModel) {

        weatherTrendIcon.image = previsionViewModel.weatherIcon

        temperatureLabel.text = previsionViewModel.temperature
        temperatureLabel.isHidden = !previsionViewModel.temperatureAvailable

        temperatureIcon.image = previsionViewModel.trendTemperatureIcon
        temperatureTrendView.isHidden = !previsionViewModel.trendTemperatureAvailable

        pressureLabel.text = previsionViewModel.pressure
        pressureLabel.isHidden = !previsionViewModel.pressureAvailable
        
        pressureIcon.image = previsionViewModel.trendPressureIcon
        pressureTrendView.isHidden = !previsionViewModel.trendPressureAvailable

        windLabel.text = previsionViewModel.windForce
        windLabel.isHidden = !previsionViewModel.windForceAvailable

        windIcon.image = previsionViewModel.windIcon
        windIcon.isHidden = !previsionViewModel.windIconAvailable

    }
}

