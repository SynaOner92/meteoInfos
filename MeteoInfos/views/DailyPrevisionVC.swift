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
    
    // MARK: var
    var dailyPrevision: DailyPrevisions = DailyPrevisions(previsions: [Prevision](), latitude: 0, longitude: 0)

    // MARK: IBOutlet
    @IBOutlet weak var hoursSC: UISegmentedControl!
    @IBOutlet weak var temperatureStackView: UIStackView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureTrendIconView: UIView!
    @IBOutlet weak var temperatureTrendIcon: UIImageView!
    @IBOutlet weak var pressureStackView: UIStackView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var pressureTrendIconView: UIView!
    @IBOutlet weak var pressureTrendIcon: UIImageView!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var windIcon: UIImageView!
    
    // MARK: VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        setSegmentedControl()
        updatePrevisionView()
    }
    
    // MARK: IBAction
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        updatePrevisionView()
    }
    
    // MARK: Private func
    private func setTitle() {
        if let date = dailyPrevision.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMMM yyyy"
            dateFormatter.locale = Locale(identifier: "FR-fr")
            self.title = "Prévisions du \(dateFormatter.string(from: date))"
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func setSegmentedControl() {
        if (dailyPrevision.numberOfPrevision == 1) {
            // todo hide segment
        } else {
            for (index, prevision) in dailyPrevision.previsions.enumerated() {
                index > 1 ? hoursSC.insertSegment(withTitle: prevision.dateDisplay, at: index, animated: false) : hoursSC.setTitle(prevision.dateDisplay, forSegmentAt: index)
            }
        }
    }
    
    private func updatePrevisionView() {
        let selectedPrevision = dailyPrevision.previsions[hoursSC.selectedSegmentIndex]
        
        temperatureLabel.text = selectedPrevision.temperature?.convertKelvinToDegreeString()
        if let pression = selectedPrevision.pressure {
            pressureLabel.isHidden = false
            pressureLabel.text = pression.convertToPascalString()
        } else {
            pressureLabel.isHidden = true
        }
        
        weatherIcon.image = ImageHelper.getWeatherPictoImage(trendWeather: PrevisionHelper.getTrendWeather(amountRain: selectedPrevision.rain,
                                                                                                           canSnow: selectedPrevision.canSnow))
        
        if let windForce = selectedPrevision.averageWind,
            let windDirection = selectedPrevision.windDirection {
            if windForce == 0 {
                windLabel.text = "Absence de vent"
                windIcon.isHidden = true
            } else {
                windLabel.text = "Force et direction du vent : \(windForce.convertVitesseToString())"
                let image = UIImage(named: "arrow")
                let rotatedImage = image?.rotate(radians: ConversionHelper.degreeToRadius(degree: windDirection%360 - 90))
                windIcon.image = rotatedImage
                windIcon.isHidden = false
            }
        } else {
            windLabel.text = "Force et direction du vent : Information indisponible"
            windIcon.isHidden = true
        }
        
        if hoursSC.selectedSegmentIndex > 0 {
            let previousPrevison = dailyPrevision.previsions[hoursSC.selectedSegmentIndex-1]
            
            if let selectedTemperature = selectedPrevision.temperature,
                let previousTemperature = previousPrevison.temperature {
                setImageView(imageView: temperatureTrendIcon,
                             selectedData: selectedTemperature,
                             previousData: previousTemperature)
                temperatureTrendIconView.isHidden = false
            } else {
                temperatureTrendIconView.isHidden = true
            }
            
            if let selectedPressure = selectedPrevision.pressure,
                let previousPressure = previousPrevison.pressure {
                    setImageView(imageView: pressureTrendIcon,
                                 selectedData: selectedPressure,
                                 previousData: previousPressure)
                    pressureTrendIconView.isHidden = false
            } else {
                pressureTrendIconView.isHidden = true
            }
        } else {
            temperatureTrendIconView.isHidden = true
            pressureTrendIconView.isHidden = true
        }
    }
    
    private func setImageView(imageView: UIImageView, selectedData: Double, previousData: Double) {
        let image = UIImage(named: selectedData == previousData ? "equal" : "arrow")
        let rotatedImage = image?.rotate(radians: ConversionHelper.degreeToRadius(degree: selectedData > previousData ? 90 : selectedData == previousData ? 0 : -90))
        imageView.image = rotatedImage
    }
    
    
}
