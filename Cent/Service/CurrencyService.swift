//
//  CurrencyService.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Moya

///Service Aliases
typealias CurrencyInfoResult   = (Swift.Result<Bool, Error>) -> ()
typealias LatestCurrencyResult = (Swift.Result<[Currency], Error>) -> ()

///Currency service protocol, used for test
protocol CurrencyServiceProtocol {
    var info: CurrencyInfo? { get set }
    
    func getCurrencyInfo(completion: @escaping CurrencyInfoResult)
    func getLatestCurrency(basedOn: String, completion: @escaping LatestCurrencyResult)
}

class CurrencyService: CurrencyServiceProtocol {
    private let apiProvider = MoyaProvider<CentAPI>()
    internal var info: CurrencyInfo?
    
    internal func getCurrencyInfo(completion: @escaping CurrencyInfoResult) {
        apiProvider.request(.getCurrencyInfo) { (result) in
            switch result {
                case .success(let response):
                    self.info = try! JSONDecoder().decode(CurrencyInfo.self, from: response.data)
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(CentError.serviceError(error: error.localizedDescription)))
            }
        }
    }
    
    func getLatestCurrency(basedOn: String, completion: @escaping LatestCurrencyResult) {
        assert(info != nil, "Invalid info data")
        
        apiProvider.request(.getLatest(based: basedOn)) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
                case .success(let response):
                    let latestCurrency = try! JSONDecoder().decode(LatestCurrency.self, from: response.data)
                    var currencies = [Currency]()
                    
                    self.info!.response.currencies.forEach({ (categoryInfo) in
                        let latestCurrencyBasedOnFilter = latestCurrency.getCurrencyArray().first(where: { (baseCurrency) -> Bool in
                            return categoryInfo.code.uppercased() == baseCurrency.code.uppercased()
                        })
                        
                        if let latestCurrencyBasedOnFilter = latestCurrencyBasedOnFilter{
                            currencies.append(Currency(info: categoryInfo, latestCurrency: latestCurrencyBasedOnFilter))
                        }
                    })
                    
                    completion(.success(currencies))
                case .failure(let error):
                    completion(.failure(CentError.serviceError(error: error.localizedDescription)))
            }
        }
    }
}
