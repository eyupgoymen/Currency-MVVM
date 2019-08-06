//
//  CurrencyListViewModel.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation


final class CurrencyListViewModel : CurrencyListViewModelProtocol {
    //MARK: Delegate
    var delegate: CurrencyListViewModelDelegate?
    var currencyService: CurrencyServiceProtocol!
    var currencies = [Currency]()
    
    //Service injection will be here with protocols
    init(currencyService: CurrencyService) {
        self.currencyService = currencyService
    }
    
    func fetchCurrencyInfo() {
        notify(.setLoading(true))
        
        currencyService.getCurrencyInfo { [weak self] (result) in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch result {
                case .success:
                    self.notify(.infoFetched)
                
                case .failure(let error):
                    self.notify(.showError(error))
            }
        }
    }
    
    func fetchRangedCurrency(startDate: String, endDate: String, based: String) {
        notify(.setLoading(true))
        
        currencyService.getCurrencyBetween(start: startDate, end: endDate, basedOn: based) { [weak self] (result) in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch result {
                case .success(let currencies):
                    self.notify(.currencyFetched(currencies))
                
                case .failure(let error):
                    self.notify(.showError(error))
            }
        }
    }
    
    func presentSelection() {
        delegate?.navigate(to: .presentBaseSelection)
    }
    
    private func notify(_ output: CurrencyListViewModelOutput) {
       delegate?.handleViewModelOutput(output)
    }
}

