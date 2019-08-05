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
    
    //MARK: Variables

     override func viewDidLoad() {
        super.viewDidLoad()
        setRegisters()
        setLayout()
        viewModel.fetchCurrencyInfo()
    }

    private func setRegisters() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellWithReuseIdentifier: "CurrencyCell")
    }
}

//MARK: Actions
extension CurrencyListViewController {
  
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
                collectionView.reloadData()
            
            case .infoFetched:
                viewModel.fetchLatestCurrency(base: "EUR")
        }
    }

     func navigate(to route: CurrencyListRoute) {
        
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
