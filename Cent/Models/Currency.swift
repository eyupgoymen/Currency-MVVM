//
//  Currency.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 5.08.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

struct Currency {
    var code: String = ""
    var symbol: String = ""
    var name: String = ""
    var value: Double = 0.0
    
    init(info: SubCurrencyInfo, latestCurrency: BaseCurrency) {
        self.code = info.code
        self.symbol = info.symbol
        self.name = info.name
        self.value = latestCurrency.value
    }
}
