//
//  SuccessViewController.swift
//  EcommerceApp
//
//  Created by Pratik on 23/06/22.
//

import UIKit

class SuccessViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contentView: UIStackView!
    
    
    private let api: API = {
        return MockAPIClient()
    }()
    
    private var orderData: Order? {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
                self.contentView.isHidden = false
            }
        }
    }
    
    private var activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.isHidden = true
        
        activityIndicatorView.style = .large
        activityIndicatorView.backgroundColor = .clear
        activityIndicatorView.center = self.view.center
        view.addSubview(activityIndicatorView)
        
        if #available(iOS 15.0, *){
            self.tableView.sectionHeaderTopPadding = 0.0
        }
        
        // hide navigation back button
        self.navigationItem.hidesBackButton = true
        
        activityIndicatorView.startAnimating()
        api.postOrderDetails { (success, data) in
            self.orderData = data
            self.priceLabel.text = self.orderData?.formattedTotalPrice
            self.addressLabel.text = self.orderData?.deliveryAddress
        }
    }
    @IBAction func didTapOnActionButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension SuccessViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        
        cell.nameLabel.text = orderData?.items[0].name
        cell.priceLabel.text = orderData?.items[0].formattedPrice
        
        cell.nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cell.priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        cell.backgroundColor = .clear
        
        cell.accessoryType = .none
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.text = "Order Details:"
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
