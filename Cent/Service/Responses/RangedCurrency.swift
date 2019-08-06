//
//  LatestCurrency.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

class RangedCurrency: Codable {
    var rates: [String: Double]
    
    init(rates: [String: Double]) {
        self.rates = rates
    }
    
    func getCurrencyArray() -> [BaseCurrency] {
        var currencies = [BaseCurrency]()
        rates.forEach { currencies.append(BaseCurrency(code: $0.key, value: $0.value))  }
        return currencies
    }
}

struct BaseCurrency {
    var code: String
    var value: Double
}



