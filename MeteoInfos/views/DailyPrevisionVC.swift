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
    @IBOutlet weak var previsionView: PrevisionView!
    
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
        
        let selectedPrevision = dailyPrevision.previsions[hoursSC.selectedSegmentIndex]
        let previousPrevision = hoursSC.selectedSegmentIndex == 0 ? nil : dailyPrevision.previsions[hoursSC.selectedSegmentIndex-1]
        previsionView.configure(withPrevisionViewModel: PrevisionViewModel(prevision: selectedPrevision, previousPrevision: previousPrevision))
        
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
        let previousPrevision = hoursSC.selectedSegmentIndex == 0 ? nil : dailyPrevision.previsions[hoursSC.selectedSegmentIndex-1]
        previsionView.configure(withPrevisionViewModel: PrevisionViewModel(prevision: selectedPrevision, previousPrevision: previousPrevision))
    }
    
    private func setImageView(imageView: UIImageView, selectedData: Double, previousData: Double) {
        let image = UIImage(named: selectedData == previousData ? "equal" : "arrow")
        let rotatedImage = image?.rotate(radians: ConversionHelper.degreeToRadius(degree: selectedData > previousData ? 90 : selectedData == previousData ? 0 : -90))
        imageView.image = rotatedImage
    }
    
    
}
