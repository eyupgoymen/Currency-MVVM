//
//  BaseSelectionCell.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 6.08.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

class BaseSelectionCell: UITableViewCell {

    @IBOutlet weak var textBackgroundView: UIView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    var currency: Currency? {
        didSet { subCurrencyInfoSetted() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }

    private func setLayout() {
        textBackgroundView.backgroundColor = UIColor(hexString: "2D2D4D")
        textBackgroundView.layer.cornerRadius = 20
        selectionStyle = .none
    }
    
    private func subCurrencyInfoSetted() {
        symbolLabel.text = currency!.symbol
        currencyNameLabel.text = currency!.name
    }
}
