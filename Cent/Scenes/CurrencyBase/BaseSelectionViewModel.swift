//
//  BaseSelectionViewModel.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 6.08.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation


final class BaseSelectionViewModel : BaseSelectionViewModelProtocol {    
    //MARK: Delegate
    var delegate: BaseSelectionViewModelDelegate?
    var currencies:  [Currency]!
    
    //Service injection will be here with protocols
    init(currencies: [Currency]) {
        self.currencies = currencies
    }
    
    func loadView() {
        notify(.gotCurrencies(currencies))
    }
    
    func currencySelected(at index: Int) {
        Constants.base = currencies[index].code.uppercased()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newBaseSelected"), object: nil)
        delegate?.navigate(to: .back)
    }
    
    func notify(_ output: BaseSelectionViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    func navigateToBack() {
        delegate?.navigate(to: .back)
    }
}

