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
    var currencyService: CurrencyServiceProtocol!
    
    //Service injection will be here with protocols
    init(currencyService: CurrencyServiceProtocol) {
        self.currencyService = currencyService
    }
    
    func fetchCurrencyInfo() {
        self.notify(.setLoading(true))
        
        currencyService.getCurrencyInfo { [weak self] (result) in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch result {
                case .success(let info):
                    self.notify(.infoFetched(info))
                case .failure(let error):
                    self.notify(.showError(error))
            }
        }
    }
    
    func navigateToBack() {
        delegate?.navigate(to: .back)
    }
    
    private func notify(_ output: BaseSelectionViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

