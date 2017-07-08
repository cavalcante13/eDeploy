//
//  SearchListViewController.swift
//  TesteEdeploy
//
//  Created by Diego Cavalcante on 07/07/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    
    lazy var address : Address = Address()
    
    var city    : String
    var state   : String
    
    init(city : String, state : String) {
        self.city   = city
        self.state  = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(city: "", state: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.searchListViewController.resultado()
        
        setup()
        register()
        loadAddress()
    }
    
    final private func setup() {
        tableView?.delegate             = self
        tableView?.dataSource           = self
        tableView?.backgroundColor      = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        tableView?.estimatedRowHeight   = 90
        tableView?.rowHeight            = UITableViewAutomaticDimension
        tableView?.tableFooterView      = UIView()
    }
    
    final private func register() {
        tableView?.register(R.nib.searchListTableViewCell)
    }
    
    final private func loadAddress() {
        AppStyle.startActivityIndicator()
        
        let service : RestableService<Address> = RestableService(path: R.string.endPoint.buscarTodasCidades(), params: [:])
        service.get(parse: Address.init, callback: loadAddressClosure())
    }
    
    final private func loadAddressClosure()-> (Any)-> () {
        return { [weak self] address in
            if let context = self {
                if let address = address as? Address {
                    context.address = address
                    address.filter(by: (context.city, context.state))
                    context.tableView?.reloadData()
                }else if let error = address as? Error {
                    context.confirmAlert(title: "Erro", description: error.localizedDescription)
                }
                AppStyle.stopActivityIndicator()
            }
        }
    }
}
extension SearchListViewController : UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return address.addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.searchListTableViewCell.identifier, for: indexPath) as! SearchListTableViewCell
        cell.address = address.addresses[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(PontuationListViewController(address : address.addresses[indexPath.item]), animated: true)
    }
}
