//
//  BaseSelectionViewController.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 6.08.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//


import Foundation
import UIKit

final class BaseSelectionViewController : UIViewController, Alertable {
    
    //MARK: View Model and Router
    var viewModel: BaseSelectionViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    //MARK: UI objects
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Variables
    var currencies = [Currency]()

     override func viewDidLoad() {
        super.viewDidLoad()
        setRegisters()
        setLayout()
        viewModel.loadView()
    }

    private func setRegisters() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "BaseSelectionCell", bundle: nil), forCellReuseIdentifier: "BaseSelectionCell")
    }
}

//MARK: View Model Delegate
extension BaseSelectionViewController : BaseSelectionViewModelDelegate {
    func handleViewModelOutput(_ output: BaseSelectionViewModelOutput) {
        switch output {
            case .gotCurrencies(let currencies):
                self.currencies = currencies
                tableView.reloadData()
        }
    }

     func navigate(to route: BaseSelectionRoute) {
        switch route {
            case .back:
                self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: Table view and collection view methods here
extension BaseSelectionViewController: TableViewProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseSelectionCell", for: indexPath) as! BaseSelectionCell
        cell.currency = currencies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension BaseSelectionViewController: BaseSelectionCellDelegate {
    func close() {
        viewModel.navigateToBack()
    }
}
