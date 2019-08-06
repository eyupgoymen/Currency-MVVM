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
    static func make(currencies: [Currency]) -> BaseSelectionViewController {
        let storyboard = UIStoryboard.init(name: "BaseSelection" , bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "BaseSelectionViewController" ) as! BaseSelectionViewController

        viewController.viewModel =  BaseSelectionViewModel(currencies: currencies)
        return viewController
    }
}

