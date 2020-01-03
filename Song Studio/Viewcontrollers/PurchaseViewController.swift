//
//  PurchaseViewController
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import UIKit

protocol PurchaseDelegate: class {
    func didPurchased()
}

class PurchaseViewController: UIViewController {

    @IBOutlet weak var purchaseListTableView: UITableView!
    weak var delegate: PurchaseDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: Action
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getPurchased() {
        DefaultWrapper().subscribed(true)
        self.delegate?.didPurchased()
    }
    
    //MARK: Alert
    private func showConfirmationAlert() {
        let confirmAction = UIAlertAction(title: "Confirm" , style: .default) { (action) in
            self.getPurchased()
            self.dismiss(animated: true, completion: nil)
        }
        
        let notnowAction = UIAlertAction(title: "Not Now" , style: .destructive) { (action) in
            
        }
        
        let alert = UIAlertController(title: "Confirm Premium Purchase", message: "Thank you for confirmation! Enjoy premium until 17th Feb 2020.", preferredStyle: .alert)
        alert.addAction(notnowAction)
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: {
        })

    }
}

//MARK: TableView dataspurce
extension PurchaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as! PurchaseCategoryCell
        cell.delegate = self
        return cell
    }
    
    
}

//MARK: TableView delegate
extension PurchaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "purchaseheader") as! PurchaseHeaderCell
        return header
    }

}

extension PurchaseViewController: MakePurchaseDelegate {
    func didPurchaseTapped() {
        self.showConfirmationAlert()
    }
    
}
