//
//  CurrencyListViewController.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//


import Foundation
import UIKit

final class CurrencyListViewController : UIViewController, Alertable, Loadable {
    
    //MARK: View Model and Router
    var viewModel: CurrencyListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var currencies = [Currency]()
    
    //MARK: UI objects
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet { collectionView.backgroundColor = .clear }
    }
    
    lazy var baseCurrencyBarButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("  Eur  ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(navigateToBaseSelection), for: .touchUpInside)
        return button
    }()
    
    //MARK: Variables

     override func viewDidLoad() {
        super.viewDidLoad()
        setRegisters()
        setLayout()
        viewModel.fetchCurrencyInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(newBaseSelected), name: NSNotification.Name("newBaseSelected"), object: nil)
    }
    
    @objc private func newBaseSelected() {
        viewModel.fetchRangedCurrency(startDate: Date.yesterday.getFormattedDateAsString(), endDate: Date().getFormattedDateAsString(), based: Constants.base)
        baseCurrencyBarButton.setTitle(Constants.base, for: .normal)
    }

    private func setRegisters() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellWithReuseIdentifier: "CurrencyCell")
    }
}

//MARK: Actions
extension CurrencyListViewController {
    @objc func navigateToBaseSelection() {
        viewModel.presentSelection()
    }
}

//MARK: View Model Delegate
extension CurrencyListViewController : CurrencyListViewModelDelegate {
    func handleViewModelOutput(_ output: CurrencyListViewModelOutput) {
        switch output {
            case .setLoading(let isShowing):
                showLoader(isShowing: isShowing)
            
            case .showError(let error):
                alert(message: error.localizedDescription, title: "Error")
            
            case .currencyFetched(let currencies):
                self.currencies = currencies
                enableBaseCurrencyBarButton()
                collectionView.reloadData()
            
            case .infoFetched:
                viewModel.fetchRangedCurrency(startDate: Date.yesterday.getFormattedDateAsString(), endDate: Date().getFormattedDateAsString(), based: Constants.base)
        }
    }

     func navigate(to route: CurrencyListRoute) {
        switch route {
            case .detail(_):
                print("")
            case .presentBaseSelection:
                let baseSelectionVC = BaseSelectionBuilder.make(currencies: currencies)
                baseSelectionVC.modalTransitionStyle = .crossDissolve
                baseSelectionVC.modalPresentationStyle = .overCurrentContext
                self.present(baseSelectionVC, animated: true, completion: nil)
        }
    }
}

//MARK: Table view and collection view methods here
extension CurrencyListViewController: CollectionViewProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        cell.currency = currencies[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width - 24 , height: 75)
    }
}
