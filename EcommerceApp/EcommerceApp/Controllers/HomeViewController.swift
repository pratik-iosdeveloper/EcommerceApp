//
//  HomeViewController.swift
//  EcommerceApp
//
//  Created by Pratik on 23/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var contentView: UIStackView!
    
    var isItemSelected: Bool = false
    
    private var storeData: Store? {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    private var productData: Product? {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
                self.contentView.isHidden = false
            }
        }
    }
    
    private let api: API = {
        return MockAPIClient()
    }()
    
    private var activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Home"
        
        self.contentView.isHidden = true
        
        activityIndicatorView.style = .large
        activityIndicatorView.backgroundColor = .clear
        activityIndicatorView.center = self.view.center
        view.addSubview(activityIndicatorView)
        
        if #available(iOS 15.0, *){
            self.tableView.sectionHeaderTopPadding = 0.0
        }
        
        activityIndicatorView.startAnimating()
        api.fetchStores { (success, data) in
            self.storeData = data
        }
        
        api.fetchProducts { (success, data) in
            self.productData = data
        }
        
        actionButton.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedRow = self.tableView.indexPathForSelectedRow?.row
        guard let product = productData?.items[selectedRow ?? 0] else {
            fatalError("Can't pass selected product information")
        }
        
        let viewController = segue.destination as! OrderSummaryViewController
        viewController.selectedProduct = product
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productData?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        
        guard let product = productData?.items[indexPath.row] else {
            fatalError("Can't display product information")
        }
        
        cell.nameLabel.text = product.name
        cell.priceLabel.text = product.formattedPrice
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell") as! StoreTableViewCell
        cell.nameLabel.text = storeData?.items[0].name
        cell.addressLabel.text = storeData?.items[0].address
        cell.phoneLabel.text = storeData?.items[0].phone
        cell.websiteLabel.text = storeData?.items[0].website
        cell.backgroundColor = .orange
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                actionButton.isEnabled = false
            } else {
                cell.accessoryType = .checkmark
                actionButton.isEnabled = true
            }
        }
    }
    
}
