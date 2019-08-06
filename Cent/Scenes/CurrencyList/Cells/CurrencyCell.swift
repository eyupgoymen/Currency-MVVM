//
//  CurrencyCell.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 2.08.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

class CurrencyCell: UICollectionViewCell {

    @IBOutlet private weak var textBackgroundView: UIView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var changeRatioLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    var currency: Currency? {
        didSet {
            currencySetted()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }

    ///Settings out initial layout cases
    private func setLayout() {
        backgroundColor = UIColor(hexString: "#454662")
        layer.cornerRadius = 7
        
        textBackgroundView.backgroundColor = UIColor.getRandomColor()
        textBackgroundView.layer.cornerRadius = 25
        
        symbolLabel.textColor = .white
        symbolLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        valueLabel.textColor = .white
        valueLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        changeRatioLabel.textColor = .white
        changeRatioLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        currencyNameLabel.textColor = .white
        currencyNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    private func currencySetted() {
        valueLabel.text = "\(currency!.value.rounded(toPlaces: 4))"
        currencyNameLabel.text = currency!.name
        symbolLabel.text = currency!.symbol
        changeRatioLabel.text = "\(currency!.ratio.rounded(toPlaces: 4))"
    }
}
