//
//  SearchListTableViewCell.swift
//  TesteEdeploy
//
//  Created by Diego Cavalcante on 07/07/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel?
    @IBOutlet weak var stateLabel: UILabel?
    
    
    var address : Address? {
        didSet {
            cityLabel?.text     = address?.city
            stateLabel?.text    = address?.state
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
