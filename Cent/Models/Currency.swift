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
    var ratio: Double = 0.0
    
    init(info: SubCurrencyInfo, todayCurrency: BaseCurrency, prevCurrency: BaseCurrency) {
        self.code = info.code
        self.symbol = info.symbol
        self.name = info.name
        self.value = todayCurrency.value
        self.ratio = (todayCurrency.value - prevCurrency.value) / prevCurrency.value * 100
    }
}
