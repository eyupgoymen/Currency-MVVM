//
//  ServiceTest.swift
//  CentTests
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import XCTest
@testable import Cent

class ServiceTest: XCTestCase {
    
    func testCurrencyInfo() throws {
        let data = try getDataFromBundle(fileName: "CurrencyInfo", ext: "json")
        let info = try JSONDecoder().decode(CurrencyInfo.self, from: data)
        
        XCTAssertEqual(info.response.currencies.first?.code, "AED")
        XCTAssertEqual(info.response.currencies.count, 60)
    }
    
    func testLatestCurrency() throws {
        let data = try getDataFromBundle(fileName: "LatestCurrency", ext: "json")
        let currency = try JSONDecoder().decode(RangedCurrency.self, from: data)
        let currencyArray = currency.getCurrencyArray()
        
        XCTAssertEqual(currency.rates.count, 33)
        XCTAssertEqual(currencyArray.count, 33)
    }
    
    func getDataFromBundle(fileName: String, ext: String) throws -> Data {
        let bundle = Bundle(for: ServiceTest.self)
        let url = try bundle.url(forResource: fileName, withExtension: ext).unwrap()
        return try Data(contentsOf: url)
    }
}
