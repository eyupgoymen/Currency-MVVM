//
//  BaseSelectionBuilder.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 6.08.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation
import UIKit

final class BaseSelectionBuilder {
    static func make() -> BaseSelectionViewController {
        let storyboard = UIStoryboard.init(name: "BaseSelection" , bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "BaseSelectionViewController" ) as! BaseSelectionViewController

        viewController.viewModel =  BaseSelectionViewModel(currencyService: CurrencyService())
        
        return viewController
    }
}

