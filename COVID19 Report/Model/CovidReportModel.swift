//
//  CovidReportModel.swift
//  COVID19 Report
//
//  Created by Siavash Jalali on 2020/05/24.
//  Copyright © 2020 Shichan Official. All rights reserved.
//

import Foundation

struct CovidReportModel : Decodable {
    let confirmed: Int
    let recovered: Int
    let critical: Int
    let deaths: Int
    let lastChange: String
    let lastUpdate: String
}

