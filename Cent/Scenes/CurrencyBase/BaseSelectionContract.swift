//
//  BaseSelectionContract.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 6.08.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

protocol BaseSelectionViewModelProtocol {
    var  delegate : BaseSelectionViewModelDelegate? { get set }
    var currencyService: CurrencyServiceProtocol! { get set }
    func fetchCurrencyInfo()
    func navigateToBack()
}

// ViewModel to view
enum BaseSelectionViewModelOutput {
    case showError(Error)
    case setLoading(Bool)
    case infoFetched(CurrencyInfo)
}

//Navigates
enum BaseSelectionRoute {
    case back
}


protocol BaseSelectionViewModelDelegate : class {
    func handleViewModelOutput(_ output: BaseSelectionViewModelOutput)
    func navigate(to route: BaseSelectionRoute)
}

protocol BaseSelectionCellDelegate: class {
    func close()
}
