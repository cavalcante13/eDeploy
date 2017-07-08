//
//  SearchViewController.swift
//  TesteEdeploy
//
//  Created by Diego Cavalcante on 07/07/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var cityTextField: UITextField?
    @IBOutlet weak var stateTextField: UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.searchViewController.busca()
    }
    
    @IBAction func searchAction(_ sender: Any) {
        let city    = cityTextField?.text ?? ""
        let state   = stateTextField?.text ?? ""
        
        let viewController = SearchListViewController(city: city, state: state)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
