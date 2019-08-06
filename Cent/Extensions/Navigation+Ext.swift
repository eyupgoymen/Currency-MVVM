//
//  Navigation+Ext.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 6.08.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setColor(_ color: UIColor) {
        navigationBar.barTintColor = color
    }
    
    func setTitleColor(_ color: UIColor) {
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color,
                                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)]
    }
}
