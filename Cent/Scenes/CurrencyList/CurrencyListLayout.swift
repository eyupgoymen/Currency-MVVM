//
//  CurrencyListLayout.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//


import UIKit

//All layout functions and animations will be here
extension CurrencyListViewController {

     override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    func setLayout() {
        view.backgroundColor = UIColor(hexString: "#2D2D4D")
        
        setNavigationBarItems()
        configureNavigationBar()
    }

    private func setNavigationBarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: baseCurrencyBarButton)
        baseCurrencyBarButton.isEnabled = false
    }
    
    func enableBaseCurrencyBarButton() {
        baseCurrencyBarButton.isEnabled = true
    }

    private func configureNavigationBar() {        
        navigationController?.setColor(UIColor(hexString: "#454662"))
        navigationItem.title = "Cent"
        navigationController?.setTitleColor(.white)
    }
}
