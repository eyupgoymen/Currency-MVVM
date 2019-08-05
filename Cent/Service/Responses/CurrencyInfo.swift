//
//  CurrencyInfoResponse.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

struct CurrencyInfo: Codable {
    var response: CurrencyInfoResponse
}

struct CurrencyInfoResponse: Codable {
    var currencies: [SubCurrencyInfo]
}

struct SubCurrencyInfo: Codable {
    var code: String
    var symbol: String
    var name: String
}
