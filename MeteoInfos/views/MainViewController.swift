//
//  ViewController.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 06/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import UIKit
import MapKit
import Reachability

@objcMembers
class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var previsionsTV: UITableView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var informationStackView: UIStackView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Private var
    private var previsionsResponse: [DailyPrevisions] = [] {
        didSet {
            previsionsTV.isHidden = previsionsResponse.count == 0
            previsionsTV.reloadData()
        }
    }
    private var location: CLLocation? = nil {
        didSet {
            loadDatas(location: location)
        }
    }
    private var isNetworkReachable: Bool? = nil {
        didSet {
            loadDatas(location: location)
        }
    }
    private var information: String? = nil {
        didSet {
            informationLabel.text = information
            informationStackView.isHidden = information == nil
        }
    }
    private var actionTitle: String? = nil {
        didSet {
            refreshButton.setTitle(actionTitle, for: .normal)
            refreshButton.layer.borderWidth = 1
            refreshButton.layer.borderColor = UIColor.black.cgColor
            refreshButton.layer.cornerRadius = 5
        }
    }
    private let manager = CLLocationManager()
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.startAnimating()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest

        previsionsTV.rowHeight = UITableView.automaticDimension
        previsionsTV.tableFooterView = UIView()
        previsionsTV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .denied {
            setAuthorizationDeniedLocation()
        }
        
        manager.requestWhenInUseAuthorization()
        
        try? addReachabilityObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeReachabilityObserver()
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
    private func loadDatas(location: CLLocation?) {
        
        if let location = location?.coordinate,
            let isNetworkReachable = isNetworkReachable {
            if isNetworkReachable {
                ApiService.sharedApiService.getPrevisionsMeteo(location: location) { [weak self] result in
                    guard let strongSelf = self else { return }
                    
                    switch result {
                    case .success(let previsions):
                        if previsions.count > 0 {
                            strongSelf.previsionsResponse = previsions
                        }
                    case .failure(let error):
                        debugPrint(error)
                        strongSelf.setCantGetPrevisions()
                    }
                }
            } else {
                let defaults = UserDefaults.standard
                if let cachedValue = defaults.value(forKey: defaultsKeys.previsionsKey) as? Data,
                    let previsionsResponse = try? PropertyListDecoder().decode([DailyPrevisions].self, from: cachedValue) {
                    
                    if previsionsResponse.first?.longitude == location.longitude && previsionsResponse.first?.latitude == location.longitude {
                        self.previsionsResponse = previsionsResponse
                    } else {
                        self.setCantGetPrevisions()
                    }
                }
            }
        }
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
    }
    
    private func setAuthorizationDeniedLocation() {
        information = "⚠️ Impossible de récupérer votre position, veuillez autoriser l'application à la récupérer."
        actionTitle = "Accéder aux paramètres"
        refreshButton.addTarget(self, action: #selector(redirectToLocationOption(sender:)), for: .touchUpInside)
    }
    
    private func setCantGetPrevisions() {
        information = "⚠️ Impossible de récupérer les informations pour le moment, veuillez vous connecter à internet."
        actionTitle = "Réessayer"
        refreshButton.addTarget(self, action: #selector(retryButton(sender:)), for: .touchUpInside)
    }
    
    // MARK: - objcMembers
    func redirectToLocationOption(sender: UIButton) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    
    func retryButton(sender: UIButton) {
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        loadDatas(location: location)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .notDetermined{
            setAuthorizationDeniedLocation()
        } else {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        setAuthorizationDeniedLocation()
        debugPrint("Failed to find user's location: \(error.localizedDescription)")
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

extension MainViewController: ReachabilityActionDelegate, ReachabilityObserverDelegate {
    func reachabilityChanged(_ isReachable: Bool) {
        if isReachable != self.isNetworkReachable {
            self.isNetworkReachable = isReachable
        }
    }
}
