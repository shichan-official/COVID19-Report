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
    
    @IBOutlet weak var totalConfirmed: UILabel!
    @IBOutlet weak var totalActive: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    @IBOutlet weak var totalCritical: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidApi.delegate = self
        covidApi.fetchCovidResults()
    }
    
    @IBAction func fetchReportButtonPressed(_ sender: UIButton) {
        covidApi.fetchCovidResults()
    }
}

//MARK: - CovidApiDelegate
extension CovidReportViewController: CovidApiDelegate {
    func didUpdateCovidData(_ covidApi: CovidApi, covid: CovidReportModel) {
        DispatchQueue.main.async {
            self.totalConfirmed.text = covid.confirmed.formattedWithSeparator
            self.totalActive.text = (covid.confirmed - covid.recovered).formattedWithSeparator
            self.totalRecovered.text = covid.recovered.formattedWithSeparator
            self.totalCritical.text = covid.critical.formattedWithSeparator
            self.totalDeaths.text = covid.deaths.formattedWithSeparator
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - Number formatting
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int{
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
