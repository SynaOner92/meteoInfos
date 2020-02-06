//
//  ViewController.swift
//  MeteoInfos
//
//  Created by Michael Coqueret on 06/02/2020.
//  Copyright © 2020 Nicolas Moranny. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        callApi()
    }

    func callApi() {
        
        let test = ApiService.sharedApiService.getPrevisionsMeteo() { response in
            print(response)
        }
    }
    

}

