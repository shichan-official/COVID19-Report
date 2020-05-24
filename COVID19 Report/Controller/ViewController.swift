//
//  ViewController.swift
//  COVID19 Report
//
//  Created by Siavash Jalali on 2020/05/24.
//  Copyright © 2020 Shichan Official. All rights reserved.
//

import UIKit

class CovidReportViewController: UIViewController {
    var covidApi = CovidApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fetchReportButtonPressed(_ sender: UIButton) {
        covidApi.fetchCovidResults()
    }
}

