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
    func navigateToBack()
    func loadView()
    func currencySelected(at index: Int)
}

// ViewModel to view
enum BaseSelectionViewModelOutput {
    case gotCurrencies([Currency])
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
