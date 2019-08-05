//
//  CurrencyListContract.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

//General MVVM structure -

import Foundation

protocol CurrencyListViewModelProtocol {
    var delegate : CurrencyListViewModelDelegate? { get set }
    var currencyService: CurrencyService! { get set }
    func fetchCurrencyInfo()
    func fetchLatestCurrency(base: String)
}

// ViewModel to view
enum CurrencyListViewModelOutput {
    case showError(Error)
    case setLoading(Bool)
    case infoFetched
    case currencyFetched([Currency])
}

//Navigates
enum CurrencyListRoute {
    case detail(CurrencyListViewModelProtocol)
}


protocol CurrencyListViewModelDelegate : class {
    func handleViewModelOutput(_ output: CurrencyListViewModelOutput)
    func navigate(to route: CurrencyListRoute)
}
