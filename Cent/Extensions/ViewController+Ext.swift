//
//  ViewController+Ext.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol Alertable {
    func alert(message: String, title: String)
}

protocol Loadable {
    func showLoader(isShowing: Bool)
}

extension Alertable where Self: UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showIndicator(isShowing: Bool) {
        isShowing == true ? SVProgressHUD.show(withStatus: "Loading...") : SVProgressHUD.dismiss()
    }
}

extension Loadable where Self: UIViewController {
    func showLoader(isShowing: Bool) {
        isShowing == true ? SVProgressHUD.show(withStatus: "Loading") : SVProgressHUD.dismiss()
    }
}
