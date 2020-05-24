//
//  CovidApi.swift
//  COVID19 Report
//
//  Created by Siavash Jalali on 2020/05/24.
//  Copyright © 2020 Shichan Official. All rights reserved.
//

import Foundation

protocol CovidApiDelegate {
    func didUpdateCovidData(_ covidApi: CovidApi, covid: CovidReportModel)
    func didFailWithError(error: Error)
}

struct CovidApi {
    
    var delegate: CovidApiDelegate?
    
    let headers = [
        "x-rapidapi-host": "covid-19-data.p.rapidapi.com",
        "x-rapidapi-key": "4c2f08982amshb172b52c5c25d33p191278jsna752813d8e7c"
    ]

    let request = NSMutableURLRequest(url: NSURL(string: "https://covid-19-data.p.rapidapi.com/totals?format=json")! as URL,
        cachePolicy: .useProtocolCachePolicy,
    timeoutInterval: 10.0)

    let session = URLSession.shared

    func fetchCovidResults() {
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                self.delegate?.didFailWithError(error: error!)
                print(error!)
            } else {
                if let covidReportData = data {
                    if let covidReport = self.parseJSON(covidReportData) {
                        self.delegate?.didUpdateCovidData(self, covid: covidReport)
                    }
                }
            }
        })
        dataTask.resume()
    }
    
    func parseJSON(_ covidReportData: Data) -> CovidReportModel? {
        let decoder = JSONDecoder()
        do {
            let decodedcovidReportData = try decoder.decode([CovidReportModel].self, from: covidReportData)
            return decodedcovidReportData.last
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
