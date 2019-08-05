//
//  CurrencyListBuilder.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation
import UIKit

final class CurrencyListBuilder {
    static func make() -> CurrencyListViewController {
        let storyboard = UIStoryboard.init(name: "CurrencyList" , bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CurrencyListViewController" ) as! CurrencyListViewController

        //Decleare view model here
        viewController.viewModel =  CurrencyListViewModel(currencyService: CurrencyService())
        
        return viewController
    }
}

