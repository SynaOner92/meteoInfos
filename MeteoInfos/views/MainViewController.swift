//
//  ViewController.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 06/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet var previsionsTV: UITableView!
    
    // MARK: - Private var
    private var previsionsResponse = [DailyPrevisions]()
    private let manager = CLLocationManager()
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        
        previsionsTV.rowHeight = UITableView.automaticDimension
        previsionsTV.tableFooterView = UIView()
        previsionsTV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        previsionsTV.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDailyPrevisions" {
            let vc = segue.destination as! DailyPrevisionVC
            let backItem = UIBarButtonItem()
            backItem.title = "Retour"
            navigationItem.backBarButtonItem = backItem
            vc.dailyPrevision = previsionsResponse[previsionsTV.indexPathForSelectedRow!.section]
        }
    }

    // MARK: - Private func
    private func loadDatas(location: CLLocation) {
        
        previsionsTV.isHidden = true
        
        ApiService.sharedApiService.getPrevisionsMeteo(location: location.coordinate) { [weak self] previsions in
            
            guard let strongSelf = self else { return }
            
            if previsions.count > 0 {
                strongSelf.previsionsResponse = previsions
                strongSelf.previsionsTV.isHidden = false
            }

            strongSelf.previsionsTV.reloadData()
            
        }
        
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            loadDatas(location: location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }

}

extension MainViewController: UITableViewDelegate { }

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return previsionsResponse.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = previsionsTV.dequeueReusableCell(withIdentifier: "PrevisionCell", for: indexPath)

        guard let previsionCell = cell as? PrevisionCell,
            indexPath.section < previsionsResponse.count
            else {
                return UITableViewCell()
        }

        if previsionsResponse.indices.contains(indexPath.section) {
            previsionCell.setup(prevision: previsionsResponse[indexPath.section])
        }

        return previsionCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDailyPrevisions", sender: self)
    }
    
}
