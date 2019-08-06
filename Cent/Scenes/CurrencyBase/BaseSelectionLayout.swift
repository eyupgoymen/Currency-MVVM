//
//  BaseSelectionLayout.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 6.08.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//


import UIKit

//All layout functions and animations will be here
extension BaseSelectionViewController {

     override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    func setLayout() {
        tableView.layer.cornerRadius = 8
        
        setNavigationBarItems()
        configureNavigationBar()
    }

    private func setNavigationBarItems() {

    }

    private func configureNavigationBar() {

    }
}
