//
//  LatestCurrency.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

struct LatestCurrency: Codable {
    var rates: [String : Double]
    
    func getCurrencyArray() -> [BaseCurrency] {
        var currencies = [BaseCurrency]()
        _ = rates.map { currencies.append(BaseCurrency(code: $0.key, value: $0.value)) }
        return currencies
    }
}

struct BaseCurrency {
    var code: String
    var value: Double
}



