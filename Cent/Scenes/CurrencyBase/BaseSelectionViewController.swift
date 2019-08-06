//
//  BaseSelectionViewController.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 6.08.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//


import Foundation
import UIKit

final class BaseSelectionViewController : UIViewController {
    
    //MARK: View Model and Router
    var viewModel: BaseSelectionViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    //MARK: UI objects
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Variables

     override func viewDidLoad() {
        super.viewDidLoad()
        setRegisters()
        setLayout()
        viewModel.fetchCurrencyInfo()
    }

    private func setRegisters() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: View Model Delegate
extension BaseSelectionViewController : BaseSelectionViewModelDelegate {
    func handleViewModelOutput(_ output: BaseSelectionViewModelOutput) {
        
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension BaseSelectionViewController: BaseSelectionCellDelegate {
    func close() {
        viewModel.navigateToBack()
    }
}
