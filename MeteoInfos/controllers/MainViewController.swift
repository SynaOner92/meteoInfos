//
//  ViewController.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 06/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet var previsionsTV: UITableView!
    
    // MARK: - Private var
    private var previsionsResponse = [Prevision]()
    private let cellSpacingHeight: CGFloat = 10
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previsionsTV.rowHeight = UITableView.automaticDimension
        previsionsTV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        loadDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        previsionsTV.reloadData()
    }

    // MARK: - Private func
    private func loadDatas() {
        
        previsionsTV.isHidden = true
        
        ApiService.sharedApiService.getPrevisionsMeteo { [weak self] previsions in
            
            guard let strongSelf = self else { return }
            
            if previsions.count > 0 {
                strongSelf.previsionsResponse = previsions
                strongSelf.previsionsTV.isHidden = false
            }
            
            strongSelf.previsionsTV.reloadData()
            
        }
        
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
}
