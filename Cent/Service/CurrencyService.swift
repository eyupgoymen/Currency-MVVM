//
//  CurrencyService.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Moya

///Service Aliases
typealias CurrencyInfoResult   = (Swift.Result<CurrencyInfo, Error>) -> ()
typealias RangedCurrencyResult = (Swift.Result<[Currency], Error>) -> ()

///Currency service protocol, used for test
protocol CurrencyServiceProtocol {
    var info: CurrencyInfo? { get set }
    
    func getCurrencyInfo(completion: @escaping CurrencyInfoResult)
    func getCurrencyBetween(start: String, end: String, basedOn: String, completion: @escaping RangedCurrencyResult)
}

class CurrencyService: CurrencyServiceProtocol {
    private let apiProvider = MoyaProvider<CentAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    internal var info: CurrencyInfo?
    private let dispatchGroup = DispatchGroup()
    
    internal func getCurrencyInfo(completion: @escaping CurrencyInfoResult) {
        apiProvider.request(.getCurrencyInfo) { (result) in
            switch result {
                case .success(let response):
                    self.info = try! JSONDecoder().decode(CurrencyInfo.self, from: response.data)
                    completion(.success(self.info!))
                case .failure(let error):
                    completion(.failure(CentError.serviceError(error: error.localizedDescription)))
            }
        }
    }

    func getCurrencyBetween(start: String, end: String, basedOn: String, completion: @escaping RangedCurrencyResult) {
        assert(info != nil, "Invalid info data")
        
        var previousRangedCurrency: RangedCurrency?
        var todayRangedCurrenct: RangedCurrency?
        var serviceError: Error?
        
        dispatchGroup.enter()
        apiProvider.request(.getCurrency(date: start, based: basedOn)) { (result) in
            switch result {
                case .success(let response):
                    previousRangedCurrency = try! JSONDecoder().decode(RangedCurrency.self, from: response.data)
                    self.dispatchGroup.leave()
                case .failure(let error):
                    serviceError = CentError.serviceError(error: error.localizedDescription)
                    self.dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        apiProvider.request(.getCurrency(date: end, based: basedOn)) { (result) in
            switch result {
                case .success(let response):
                    todayRangedCurrenct = try! JSONDecoder().decode(RangedCurrency.self, from: response.data)
                    self.dispatchGroup.leave()
                case .failure(let error):
                    serviceError = CentError.serviceError(error: error.localizedDescription)
                    self.dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if let serviceError = serviceError {
                 completion(.failure(serviceError))
                return
            }
            
            var currencies = [Currency]()
            self.info!.response.currencies.forEach({ (subCurrency) in
                let todaySubCurrency = todayRangedCurrenct!.getCurrencyArray().first(where: { (baseCurrency) -> Bool in
                    return subCurrency.code == baseCurrency.code
                })
                
                let previousSubCurrency = previousRangedCurrency!.getCurrencyArray().first(where: { (baseCurrency) -> Bool in
                    return subCurrency.code == baseCurrency.code
                })
                
                if let todaySubCurrency = todaySubCurrency, let previousSubCurrency = previousSubCurrency {
                    currencies.append(Currency(info: subCurrency, todayCurrency: todaySubCurrency, prevCurrency: previousSubCurrency))
                }
            })
            completion(.success(currencies))
        }
    }
}
